// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { Context } from "@Context/Context.sol";
import { ISalvaPool } from "@ISalvaPool/ISalvaPool.sol";
import { Clones } from "@openzeppelin/contracts/proxy/Clones.sol";
import { IERC20Metadata } from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

/**
 * @title PoolFactory
 * @author cboi@Salva
 * @notice Deploys new SalvaPool liquidity-pool clones using the EIP-1167
 * minimal-proxy pattern and exposes a token decimal utility used by the
 * off-chain backend.
 *
 * The factory holds a single implementation address set at construction time.
 * Any caller can invoke deployPool to receive their own isolated pool clone.
 * The clone is initialized immediately after deployment with the caller as its
 * deployer, granting them sole owner privileges over that pool instance (rate
 * updates, minimum amounts, pause/unpause, liquidity removal).
 *
 * Because each clone is a separate contract with its own storage, pools are
 * fully independent: one pool's liquidity, rates, and pause state have no
 * effect on any other pool deployed through this factory.
 *
 * The tokenDecimal helper exists as a convenience for the backend service,
 * which needs to know a token's decimal count before building swap calldata.
 * It simply delegates to IERC20Metadata.decimals() so the backend can call
 * one well-known address (the factory) rather than each token contract
 * directly.
 */
contract PoolFactory is Context {
    using Clones for address;

    // ─── Errors
    // ───────────────────────────────────────────────────────────────

    error Errors__ZeroAddress();

    // ─── Events
    // ───────────────────────────────────────────────────────────────

    event PoolDeployed(address indexed deployer, address indexed pool);

    // ─── State
    // ────────────────────────────────────────────────────────────────

    address internal _implementation;

    // ─── Constructor
    // ──────────────────────────────────────────────────────────

    constructor(address impl) {
        if (impl == address(0)) revert Errors__ZeroAddress();
        _implementation = impl;
    }

    // ─── Deployment
    // ───────────────────────────────────────────────────────────

    function deployPool() external returns (address pool) {
        address sender = _msgSender();
        pool = _implementation.clone();
        ISalvaPool(pool).initialize(sender);
        emit PoolDeployed(sender, pool);
    }

    // ─── Utility
    // ─────────────────────────────────────────────────────────────

    function tokenDecimal(address token) external view returns (uint8) {
        return IERC20Metadata(token).decimals();
    }

    function getImplementation() external view returns (address) {
        return _implementation;
    }
}
