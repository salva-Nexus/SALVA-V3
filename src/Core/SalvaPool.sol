// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { SalvaMath } from "@SalvaMath/SalvaMath.sol";
import { SalvaOracle } from "@SalvaOracle/SalvaOracle.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

abstract contract SalvaPool is SalvaOracle {
    using SafeERC20 for IERC20;
    using SalvaMath for uint256;

    /**
     * @notice Emergncy stop: Pauses all swap functions in the pool.
     */
    function pause() external onlyDeployer(DEPLOYER) returns (bool) {
        PAUSED = true;
        emit Paused(_msgSender());
        return true;
    }

    /**
     * @notice Resume: Re-activates swap functions.
     */
    function unpause() external onlyDeployer(DEPLOYER) returns (bool) {
        PAUSED = false;
        emit Unpaused(_msgSender());
        return true;
    }

    function swapToToken(
        address _receiver,
        address _swapTokenOut,
        address _ngnsToken,
        uint256 _ngnsAmountIn
    ) external whenNotPaused(PAUSED) returns (bool) {
        _onlySupportedToken(_swapTokenOut);
        _onlySupportedToken(_ngnsToken);
        uint256 _exRate = _getBuyRate();
        uint256 swapTokenOut = _ngnsAmountIn.calculateTokenAmountOut(_exRate, S_FACTOR);
        IERC20(_ngnsToken).safeTransferFrom(_msgSender(), address(this), _ngnsAmountIn);
        IERC20(_swapTokenOut).safeTransfer(_receiver, swapTokenOut);
        emit SwappedToToken(_receiver, _swapTokenOut, _ngnsAmountIn, swapTokenOut);
        return true;
    }

    function swapToNGNs(
        address _receiver,
        address _swapTokenIn,
        address _ngnsTokenOut,
        uint256 _tokenAmountIn
    ) external whenNotPaused(PAUSED) returns (bool) {
        _onlySupportedToken(_swapTokenIn);
        _onlySupportedToken(_ngnsTokenOut);
        uint256 _exRate = _getSellRate();

        uint256 swapNGNsOut = _tokenAmountIn.calculateNGNsAmountOut(_exRate, S_FACTOR);
        IERC20(_swapTokenIn).safeTransferFrom(_msgSender(), address(this), _tokenAmountIn);
        IERC20(_ngnsTokenOut).safeTransfer(_receiver, swapNGNsOut);
        emit SwappedToNGNs(_receiver, _swapTokenIn, _tokenAmountIn, swapNGNsOut);
        return true;
    }
}
