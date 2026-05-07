// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { Context } from "@Context/Context.sol";
import { ISalvaPool } from "@ISalvaPool/ISalvaPool.sol";
import { Clones } from "@openzeppelin/contracts/proxy/Clones.sol";
import { ERC1967Utils } from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Utils.sol";
import { Initializable } from "@openzeppelin/contracts/proxy/utils/Initializable.sol";
import { UUPSUpgradeable } from "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";

/**
 * @title PoolFactory
 * @author cboi@Salva
 * @notice Factory for deploying and managing Salva V3 DeployPool EIP-1167 minimal proxies.
 *
 * @dev Each LP deploys their own pool clone via {deployPool}.
 *      The MultiSig controls all administrative operations and upgrades.
 */
contract PoolFactory is Initializable, UUPSUpgradeable, Context {
    using Clones for address;

    // ─────────────────────────────────────────────────────────────────────────
    // ERRORS
    // ─────────────────────────────────────────────────────────────────────────

    error Errors__NotAuthorized();
    error Errors__ZeroAddress();

    // ─────────────────────────────────────────────────────────────────────────
    // EVENTS
    // ─────────────────────────────────────────────────────────────────────────

    event PoolDeployed(address indexed deployer, address indexed pool);
    event ImplementationUpdated(address oldImpl, address newImpl);
    event MultiSigUpdated(address oldMultiSig, address newMultiSig);

    // ─────────────────────────────────────────────────────────────────────────
    // STATE
    // ─────────────────────────────────────────────────────────────────────────

    /// @dev The DeployPool logic implementation used for EIP-1167 clone deployment.
    address internal _implementation;

    /// @dev The authorized Salva MultiSig address for all administrative operations.
    address internal _multiSig;

    uint256[50] private __gap;

    // ─────────────────────────────────────────────────────────────────────────
    // CONSTRUCTOR
    // ─────────────────────────────────────────────────────────────────────────

    constructor() {
        _disableInitializers();
    }

    // ─────────────────────────────────────────────────────────────────────────
    // INITIALIZER
    // ─────────────────────────────────────────────────────────────────────────

    /**
     * @notice Initializes the PoolFactory proxy.
     * @param impl     The DeployPool logic implementation address.
     * @param multiSig The Salva MultiSig address for governance.
     */
    function initialize(address impl, address multiSig) public initializer {
        if (impl == address(0) || multiSig == address(0)) {
            revert Errors__ZeroAddress();
        }
        _implementation = impl;
        _multiSig = multiSig;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // POOL DEPLOYMENT
    // ─────────────────────────────────────────────────────────────────────────

    /**
     * @notice Deploys a new DeployPool clone for the caller.
     * @dev Initializes the clone with the caller as the pool deployer.
     *      Emits {PoolDeployed} for off-chain tracking.
     * @return pool The address of the newly deployed pool clone.
     */
    function deployPool() external returns (address pool) {
        pool = _implementation.clone();
        ISalvaPool(pool).initialize(_msgSender());
        emit PoolDeployed(_msgSender(), pool);
    }

    // ─────────────────────────────────────────────────────────────────────────
    // ADMINISTRATIVE
    // ─────────────────────────────────────────────────────────────────────────

    /**
     * @notice Updates the DeployPool logic implementation for future clones.
     * @param newImpl The new implementation address.
     */
    function updateImplementation(address newImpl) external onlyMultiSig {
        emit ImplementationUpdated(_implementation, newImpl);
        _implementation = newImpl;
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

    /**
     * @notice Returns the current ERC-1967 implementation address of this proxy.
     */
    function getProxyImplementation() external view returns (address) {
        return ERC1967Utils.getImplementation();
    }

    /**
     * @notice Returns the current MultiSig address.
     */
    function getMultiSig() external view returns (address) {
        return _multiSig;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // MODIFIERS
    // ─────────────────────────────────────────────────────────────────────────

    modifier onlyMultiSig() {
        if (_msgSender() != _multiSig) revert Errors__NotAuthorized();
        _;
    }

    // ─────────────────────────────────────────────────────────────────────────
    // UUPS UPGRADE AUTHORIZATION
    // ─────────────────────────────────────────────────────────────────────────

    function _authorizeUpgrade(address newImplementation) internal override onlyMultiSig { }
}
