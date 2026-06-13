// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { SalvaOracle } from "@SalvaOracle/SalvaOracle.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

/**
 * @title SwapEngine
 * @author cboi@Salva
 * @notice Implements the four public swap entry-points and the internal
 * settlement function for the Salva V3 pool.
 *
 * The engine exposes two swap families, each with two modes:
 *
 * NGN → USD (buy USD / sell NGN):
 *   - swapExactNGNAmountForUSD  — caller specifies the exact NGN amount to
 *     spend; the engine calculates and delivers the resulting USD output.
 *   - swapForExactUSDAmount     — caller specifies the exact USD amount to
 *     receive; the engine calculates and pulls the required NGN input.
 *
 * USD → NGN (sell USD / buy NGN):
 *   - swapExactUSDAmountForNGN  — caller specifies the exact USD amount to
 *     spend; the engine calculates and delivers the resulting NGN output.
 *   - swapForExactNGNAmount     — caller specifies the exact NGN amount to
 *     receive; the engine calculates and pulls the required USD input.
 *
 * Every entry-point enforces three guards before settlement:
 *   1. whenNotPaused — the pool's circuit-breaker must be inactive.
 *   2. onlySupportedNgnDecimal — the NGN token passed in must carry exactly
 *      6 decimals; any 18-decimal token used in the NGN slot reverts here.
 *   3. Minimum amount check — the input (or computed input for exact-output
 *      variants) must meet the floor set by the pool owner via setMinimums.
 *
 * Settlement is handled by the single internal function _executeSwap, which
 * pulls the input token from msg.sender via safeTransferFrom and pushes the
 * output token to the receiver via safeTransfer. The bool _ngnOut flag
 * determines which direction the transfer pair flows.
 */
abstract contract SwapEngine is SalvaOracle {
    using SafeERC20 for IERC20;

    // ─── NGN → USD
    // ────────────────────────────────────────────────────────────

    function swapExactNGNAmountForUSD(
        address _receiver,
        address _usdTokenOut,
        address _ngnTokenIn,
        uint256 _ngnAmountIn
    ) public whenNotPaused returns (bool) {
        _onlySupportedNgnDecimal(_ngnTokenIn);
        uint256 exRate = _getBuyRate();
        if (exRate == 0) {
            revert Errors__Invalid_Rate(exRate);
        }
        if (_ngnAmountIn < minNgnAmount) {
            revert Errors__Amount_Too_Low(_ngnAmountIn);
        }
        uint256 usdAmountOut = getExactUSDAmountOut(_usdTokenOut, _ngnAmountIn, exRate);

        emit SwappedToUSD(_receiver, _usdTokenOut, _ngnAmountIn, usdAmountOut);
        return _executeSwap(
            _ngnTokenIn, _usdTokenOut, _receiver, _ngnAmountIn, usdAmountOut, false
        );
    }

    function swapForExactUSDAmount(
        address _receiver,
        address _usdTokenOut,
        address _ngnTokenIn,
        uint256 _usdAmountOut
    ) external whenNotPaused returns (bool) {
        _onlySupportedNgnDecimal(_ngnTokenIn);
        uint256 exRate = _getBuyRate();
        if (exRate == 0) {
            revert Errors__Invalid_Rate(exRate);
        }
        uint256 exactNgnAmountIn =
            getExactNGNAmountIn(_usdTokenOut, _usdAmountOut, exRate);
        if (exactNgnAmountIn < minNgnAmount) {
            revert Errors__Amount_Too_Low(exactNgnAmountIn);
        }
        emit SwappedToUSD(_receiver, _usdTokenOut, exactNgnAmountIn, _usdAmountOut);
        return _executeSwap(
            _ngnTokenIn, _usdTokenOut, _receiver, exactNgnAmountIn, _usdAmountOut, false
        );
    }

    // ─── USD → NGN
    // ────────────────────────────────────────────────────────────

    function swapExactUSDAmountForNGN(
        address _receiver,
        address _usdTokenIn,
        address _ngnTokenOut,
        uint256 _usdAmountIn
    ) public whenNotPaused returns (bool) {
        _onlySupportedNgnDecimal(_ngnTokenOut);
        uint256 exRate = _getSellRate();
        if (exRate == 0) {
            revert Errors__Invalid_Rate(exRate);
        }
        if (_usdAmountIn < minUsdAmount) {
            revert Errors__Amount_Too_Low(_usdAmountIn);
        }
        uint256 ngnAmountOut = getExactNGNAmountOut(_usdTokenIn, _usdAmountIn, exRate);
        emit SwappedToNGN(_receiver, _usdTokenIn, _usdAmountIn, ngnAmountOut);
        return _executeSwap(
            _ngnTokenOut, _usdTokenIn, _receiver, ngnAmountOut, _usdAmountIn, true
        );
    }

    function swapForExactNGNAmount(
        address _receiver,
        address _usdTokenIn,
        address _ngnTokenOut,
        uint256 _ngnAmountOut
    ) external whenNotPaused returns (bool) {
        _onlySupportedNgnDecimal(_ngnTokenOut);
        uint256 exRate = _getSellRate();
        if (exRate == 0) {
            revert Errors__Invalid_Rate(exRate);
        }
        uint256 exactUsdAmountIn = getExactUSDAmountIn(_usdTokenIn, _ngnAmountOut, exRate);
        if (exactUsdAmountIn < minUsdAmount) {
            revert Errors__Amount_Too_Low(exactUsdAmountIn);
        }
        emit SwappedToNGN(_receiver, _usdTokenIn, exactUsdAmountIn, _ngnAmountOut);
        return _executeSwap(
            _ngnTokenOut, _usdTokenIn, _receiver, _ngnAmountOut, exactUsdAmountIn, true
        );
    }

    // ─── Settlement
    // ───────────────────────────────────────────────────────────

    function _executeSwap(
        address _ngnToken,
        address _usdToken,
        address _receiver,
        uint256 _ngnAmount,
        uint256 _usdAmount,
        bool _ngnOut
    ) internal returns (bool) {
        if (!_ngnOut) {
            IERC20(_ngnToken).safeTransferFrom(_msgSender(), address(this), _ngnAmount);
            IERC20(_usdToken).safeTransfer(_receiver, _usdAmount);
        } else {
            IERC20(_usdToken).safeTransferFrom(_msgSender(), address(this), _usdAmount);
            IERC20(_ngnToken).safeTransfer(_receiver, _ngnAmount);
        }
        return true;
    }
}
