// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { Errors } from "@Errors/Errors.sol";
import { PoolFactory } from "@PoolFactory/PoolFactory.sol";
import { Setup } from "@Setup/Setup.t.sol";

contract PoolFactoryTest is Setup {
    function testOnlyMultisigCanUpdateAndUpgradeFactory(address _prank) external {
        vm.assume(_prank != address(MULTISIG));
        _changePrank(_prank);
        vm.expectRevert(PoolFactory.Errors__NotAuthorized.selector);
        POOLFACTORY.updateImplementation(address(0x123));

        vm.expectRevert(PoolFactory.Errors__NotAuthorized.selector);
        POOLFACTORY.upgradeToAndCall(address(0x123), "");
    }

    function testFactoryUpgrade() external {
        address pImpl = POOLFACTORY.getProxyImplementation();
        _changePrank(MAINDEPLOYER);
        PoolFactory nImpl = new PoolFactory();
        MULTISIG.proposeUpgrade(address(POOLFACTORY), address(nImpl));
        MULTISIG.validateUpgrade(address(nImpl));
        vm.warp(block.timestamp + 2 hours);
        MULTISIG.executeUpgrade(address(nImpl));

        address exImpl = POOLFACTORY.getProxyImplementation();
        assertNotEq(exImpl, pImpl);
        assertEq(exImpl, address(nImpl));
    }
}
