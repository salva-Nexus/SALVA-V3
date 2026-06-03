// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title PoolStorage
 * @author cboi@Salva
 * @notice Defines all storage variables and numeric constants shared across
 * the SalvaPool inheritance tree.
 */
abstract contract PoolStorage {
    // ─── Constants
    // ────────────────────────────────────────────────────────────

    uint256 internal constant NGN_DECIMALS = 6;
    uint256 internal constant NGN_PRECISION = 1e6;
    uint256 internal constant TOKEN_DECIMALS_18 = 18;
    uint256 internal constant TOKEN_PRECISION_18 = 1e18;
    uint256 internal constant DECIMAL_NORMALIZER = 1e12;

    // ─── Mutable state
    // ────────────────────────────────────────────────────────

    address internal deployer;
    bool internal paused;
    bool internal initialized;
    uint128 internal buyRate;
    uint128 internal sellRate;
    uint128 internal minNgnAmount;
    uint128 internal minUsdAmount;
}
