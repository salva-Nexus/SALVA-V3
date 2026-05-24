// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

abstract contract PoolStorage {
    uint256 internal constant S_FACTOR = 1e6;
    uint256 internal constant SUPPORTED_TOKEN_DECIMAL = 6;
    address internal DEPLOYER;
    bool internal PAUSED;
    bool internal _initialized;
    uint128 internal _buyRate;
    uint128 internal _sellRate;
    uint128 internal _minNgnAmount;
    uint128 internal _minTokenAmount;
}
