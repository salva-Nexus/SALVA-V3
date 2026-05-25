// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { Context } from "@Context/Context.sol";
import { ISalvaPool } from "@ISalvaPool/ISalvaPool.sol";
import { Clones } from "@openzeppelin/contracts/proxy/Clones.sol";

/**
 * @title PoolFactory
 * @author cboi@Salva
 * @notice Factory for deploying and managing Salva V3 DeployPool EIP-1167 minimal proxies.
 *
 * @dev Each LP deploys their own pool clone via {deployPool}.
 */
contract PoolFactory is Context {
    using Clones for address;

    // ─────────────────────────────────────────────────────────────────────────
    // ERRORS
    // ─────────────────────────────────────────────────────────────────────────
    error Errors__ZeroAddress();

    // ─────────────────────────────────────────────────────────────────────────
    // EVENTS
    // ─────────────────────────────────────────────────────────────────────────

    event PoolDeployed(address indexed deployer, address indexed pool);

    // ─────────────────────────────────────────────────────────────────────────
    // STATE
    // ─────────────────────────────────────────────────────────────────────────

    /// @dev The DeployPool logic implementation used for EIP-1167 clone deployment.
    address internal _implementation;

    // ─────────────────────────────────────────────────────────────────────────
    // CONSTRUCTOR
    // ─────────────────────────────────────────────────────────────────────────

    constructor(address impl) {
        if (impl == address(0)) {
            revert Errors__ZeroAddress();
        }
        _implementation = impl;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // POOL DEPLOYMENT
    // ─────────────────────────────────────────────────────────────────────────

    /**
     * @notice Deploys a new DeployPool clone for the caller.
     * @dev Initializes the clone with the caller as the pool deployer.
     *      Emits {PoolDeployed} for off-chain tracking.
     * @return pool The address of the newly deployed pool clone..
     */
    function deployPool() external returns (address pool) {
        address sender = _msgSender();
        pool = _implementation.clone();
        ISalvaPool(pool).initialize(sender);
        emit PoolDeployed(sender, pool);
    }

    // ─────────────────────────────────────────────────────────────────────────
    // VIEW
    // ─────────────────────────────────────────────────────────────────────────

    /**
     * @notice Returns the current DeployPool logic implementation address.
     */
    function getImplementation() external view returns (address) {
        return _implementation;
    }
}
