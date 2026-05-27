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

  function getMinuimumNgnAmount() external view returns (uint256) {
    return uint256(_minNgnAmount);
  }

  function getMinuimumUSDAmount() external view returns (uint256) {
    return uint256(_minUsdAmount);
  }

  function getExactUSDAmountOut(uint256 ngnAmountIn, uint256 exRate) public pure returns (uint256) {
    return ngnAmountIn.calculateUSDAmountOut(exRate, S_FACTOR);
  }

  function getExactNGNAmountOut(uint256 usdAmountIn, uint256 exRate) public pure returns (uint256) {
    return usdAmountIn.calculateNGNAmountOut(exRate, S_FACTOR);
  }

  function getExactNGNAmountIn(uint256 usdAmountOut, uint256 exRate) public pure returns (uint256) {
    return usdAmountOut.calculateExactNGNAmountIn(exRate, S_FACTOR);
  }

  function getExactUSDAmountIn(uint256 ngnAmountOut, uint256 exRate) public pure returns (uint256) {
    return ngnAmountOut.calculateExactUSDAmountIn(exRate, S_FACTOR);
  }

  function getDeployer() external view returns (address) {
    return DEPLOYER;
  }

  function _onlySupportedToken(address token) internal view {
    uint256 tokenDecimal = IERC20Metadata(token).decimals();
    if (tokenDecimal != SUPPORTED_TOKEN_DECIMAL) {
      revert Errors__Invalid_Swap_Token();
    }
  }
}
