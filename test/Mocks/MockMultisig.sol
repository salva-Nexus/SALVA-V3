// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

contract MockMultisig {
    struct UpgradeProposal {
        address proxy;
        address newImpl;
        uint256 timeLock;
        bool isValidated;
        bool isExecuted;
    }

    mapping(address => UpgradeProposal) public upgradeProposals;
    address public admin;
    uint256 public constant TIME_INTERVAL = 1 hours;

    error NotAdmin();
    error TimelockNotElapsed();
    error UpgradeFailed();

    constructor() {
        admin = msg.sender;
    }

    modifier onlyAdmin() {
        if (msg.sender != admin) revert NotAdmin();
        _;
    }

    /**
     * @notice Simulates proposing an upgrade.
     */
    function proposeUpgrade(address proxy, address newImpl) external onlyAdmin {
        upgradeProposals[newImpl] = UpgradeProposal({
            proxy: proxy, newImpl: newImpl, timeLock: 0, isValidated: false, isExecuted: false
        });
    }

    /**
     * @notice Simulates reaching quorum and setting the timelock.
     */
    function validateUpgrade(address newImpl) external onlyAdmin {
        UpgradeProposal storage p = upgradeProposals[newImpl];
        p.isValidated = true;
        p.timeLock = block.timestamp + TIME_INTERVAL;
    }

    /**
     * @notice Executes the upgrade.
     */
    function executeUpgrade(address newImpl) external onlyAdmin returns (bool success) {
        UpgradeProposal storage p = upgradeProposals[newImpl];

        if (block.timestamp < p.timeLock) revert TimelockNotElapsed();

        p.isExecuted = true;

        // Upgrade the external Pool Factory
        bytes memory data = abi.encodeWithSignature("upgradeToAndCall(address,bytes)", newImpl, "");
        (success,) = p.proxy.call(data);
        if (!success) revert UpgradeFailed();
    }
}
