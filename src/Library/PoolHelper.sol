// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { Errors } from "@Errors/Errors.sol";
import { SalvaMath } from "@SalvaMath/SalvaMath.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { IERC20Metadata } from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

abstract contract PoolHelper is Errors {
    using SalvaMath for uint256;

    function availableLiquidity(address asset) external view returns (uint256) {
        return IERC20(asset).balanceOf(address(this));
    }

    function getDeployer() external view returns (address) {
        return DEPLOYER;
    }

    function getExactTokenOut(uint256 ngnsAmountIn, uint256 exRate) public pure returns (uint256) {
        return ngnsAmountIn.calculateTokenAmountOut(exRate, S_FACTOR);
    }

    function getExactNGNsOut(uint256 tokenAmountIn, uint256 exRate) public pure returns (uint256) {
        return tokenAmountIn.calculateNGNsAmountOut(exRate, S_FACTOR);
    }

    function _onlySupportedToken(address token) internal view {
        uint256 tokenDecimal = IERC20Metadata(token).decimals();
        if (tokenDecimal != SUPPORTED_TOKEN_DECIMAL) {
            revert Errors__Invalid_Swap_Token();
        }
    }
}
