// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { SalvaOracle } from "@SalvaOracle/SalvaOracle.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

abstract contract SwapEngine is SalvaOracle {
    using SafeERC20 for IERC20;

    /**
     * @notice Emergncy stop: Pauses all swap functions in the pool.
     */
    function pause() external onlyDeployer returns (bool) {
        PAUSED = true;
        emit Paused(_msgSender());
        return true;
    }

    /**
     * @notice Resume: Re-activates swap functions.
     */
    function unpause() external onlyDeployer returns (bool) {
        PAUSED = false;
        emit Unpaused(_msgSender());
        return true;
    }

    function swapExactNGNAmountForToken(
        address _receiver,
        address _swapTokenOut,
        address _ngnsToken,
        uint256 _ngnsAmountIn
    ) public whenNotPaused returns (bool) {
        _onlySupportedToken(_swapTokenOut);
        _onlySupportedToken(_ngnsToken);
        uint256 _exRate = _getBuyRate();
        if (_exRate == 0) {
            revert Errors__Invalid_Rate(_exRate);
        }
        uint256 swapTokenOut = getExactTokenAmountOut(_ngnsAmountIn, _exRate);
        IERC20(_ngnsToken).safeTransferFrom(_msgSender(), address(this), _ngnsAmountIn);
        IERC20(_swapTokenOut).safeTransfer(_receiver, swapTokenOut);
        emit SwappedToToken(_receiver, _swapTokenOut, _ngnsAmountIn, swapTokenOut);
        return true;
    }

    function swapExactTokenAmountForNGN(
        address _receiver,
        address _swapTokenIn,
        address _ngnsTokenOut,
        uint256 _tokenAmountIn
    ) public whenNotPaused returns (bool) {
        _onlySupportedToken(_swapTokenIn);
        _onlySupportedToken(_ngnsTokenOut);
        uint256 _exRate = _getSellRate();
        if (_exRate == 0) {
            revert Errors__Invalid_Rate(_exRate);
        }
        uint256 swapNGNsOut = getExactNGNsAmountOut(_tokenAmountIn, _exRate);
        IERC20(_swapTokenIn).safeTransferFrom(_msgSender(), address(this), _tokenAmountIn);
        IERC20(_ngnsTokenOut).safeTransfer(_receiver, swapNGNsOut);
        emit SwappedToNGNs(_receiver, _swapTokenIn, _tokenAmountIn, swapNGNsOut);
        return true;
    }

    function swapForExactTokenAmount(
        address _receiver,
        address _swapTokenOut,
        address _ngnsTokenIn,
        uint256 _tokenAmountOut
    ) external whenNotPaused returns (bool) {
        uint256 _exRate = _getBuyRate();
        uint256 exactNGNsAmountIn = getExactNGNsAmountIn(_tokenAmountOut, _exRate);
        return swapExactNGNAmountForToken(_receiver, _swapTokenOut, _ngnsTokenIn, exactNGNsAmountIn);
    }

    function swapForExactNGNAmount(
        address _receiver,
        address _swapTokenIn,
        address _ngnsTokenOut,
        uint256 _ngnsAmountOut
    ) external whenNotPaused returns (bool) {
        uint256 _exRate = _getSellRate();
        uint256 exactTokenAmountIn = getExactTokenAmountIn(_ngnsAmountOut, _exRate);
        return
            swapExactTokenAmountForNGN(_receiver, _swapTokenIn, _ngnsTokenOut, exactTokenAmountIn);
    }
}
