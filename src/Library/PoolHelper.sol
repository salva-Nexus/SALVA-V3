// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { Errors } from "@Errors/Errors.sol";
import { SalvaMath } from "@SalvaMath/SalvaMath.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { IERC20Metadata } from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

/**
 * @title PoolHelper
 * @author cboi@Salva
 * @notice Pure view helpers and quote functions used by SwapEngine and the
 * public pool interface.
 *
 * This contract handles two concerns:
 *
 * Liquidity inspection — callers (including the off-chain backend) can query
 * the real-time token balance held by this pool contract for any asset address,
 * and can read the current minimum swap amounts enforced by the pool owner.
 *
 * Quote math — four public view functions cover every swap direction:
 *   - getExactUSDAmountOut: given an exact NGN input, returns how much USD
 *     the caller receives at the current buy rate.
 *   - getExactNGNAmountOut: given an exact USD input, returns how much NGN
 *     the caller receives at the current sell rate.
 *   - getExactNGNAmountIn: given a desired exact USD output, returns the NGN
 *     input required at the current buy rate.
 *   - getExactUSDAmountIn: given a desired exact NGN output, returns the USD
 *     input required at the current sell rate.
 *
 * All four functions branch on whether the USD token carries 6 or 18 decimals.
 * For 18-decimal tokens the raw amount is scaled down by DECIMAL_NORMALIZER
 * (1e12) before being fed into SalvaMath, which always works in 6-decimal
 * precision. The scaling is only applied to amounts, never to rates.
 */
abstract contract PoolHelper is Errors {
    using SalvaMath for uint256;

    // ─── Liquidity
    // ────────────────────────────────────────────────────────────

    function availableLiquidity(address asset) external view returns (uint256) {
        return IERC20(asset).balanceOf(address(this));
    }

    function getMinuimumNgnAmount() public view returns (uint256) {
        return uint256(minNgnAmount);
    }

    function getMinuimumUSDAmount() public view returns (uint256) {
        return uint256(minUsdAmount);
    }

    // ─── Internal helpers
    // ─────────────────────────────────────────────────────

    function _precisionFor(address usdToken) internal view returns (uint256) {
        return _decimalsOf(usdToken) == NGN_DECIMALS ? NGN_PRECISION : TOKEN_PRECISION_18;
    }

    function _decimalsOf(address token) internal view returns (uint8) {
        return IERC20Metadata(token).decimals();
    }

    // ─── Quote functions
    // ──────────────────────────────────────────────────────

    function getExactUSDAmountOut(address usdToken, uint256 ngnAmountIn, uint256 exRate)
        public
        view
        returns (uint256)
    {
        return ngnAmountIn.calculateUSDAmountOut(exRate, _precisionFor(usdToken));
    }

    function getExactNGNAmountOut(address usdToken, uint256 usdAmountIn, uint256 exRate)
        public
        view
        returns (uint256)
    {
        if (_decimalsOf(usdToken) == TOKEN_DECIMALS_18) {
            usdAmountIn = usdAmountIn.scaleDown(DECIMAL_NORMALIZER);
        }
        return usdAmountIn.calculateNGNAmountOut(exRate, NGN_PRECISION);
    }

    function getExactNGNAmountIn(address usdToken, uint256 usdAmountOut, uint256 exRate)
        public
        view
        returns (uint256)
    {
        if (_decimalsOf(usdToken) == TOKEN_DECIMALS_18) {
            usdAmountOut = usdAmountOut.scaleDown(DECIMAL_NORMALIZER);
        }
        return usdAmountOut.calculateExactNGNAmountIn(exRate, NGN_PRECISION);
    }

    function getExactUSDAmountIn(address usdTokenIn, uint256 ngnAmountOut, uint256 exRate)
        public
        view
        returns (uint256)
    {
        return ngnAmountOut.calculateExactUSDAmountIn(exRate, _precisionFor(usdTokenIn));
    }

    // ─── Owner / state views
    // ──────────────────────────────────────────────────

    function getDeployer() public view returns (address) {
        return deployer;
    }

    function isPaused() external view returns (bool) {
        return paused;
    }
}
