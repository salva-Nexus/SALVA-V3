// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { BaseTest } from "@BaseTest/BaseTest.t.sol";
import { ISalvaPool } from "@ISalvaPool/ISalvaPool.sol";
import { MockMultisig } from "@MockMultisig/MockMultisig.sol";
import { MockNGNs } from "@MockNGNs/MockNGNs.sol";
import { MockUSDC } from "@MockUSDC/MockUSDC.sol";
import { PoolFactory } from "@PoolFactory/PoolFactory.sol";
import { SalvaPool } from "@SalvaPool/SalvaPool.sol";
import { ERC1967Proxy } from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";

abstract contract Setup is BaseTest {
    function setUp() external {
        MAINDEPLOYER = makeAddr("MAINDEPLOYER");

        _changePrank(MAINDEPLOYER);
        MULTISIG = new MockMultisig();
        SalvaPool poolImpl = new SalvaPool();
        POOLFACTORY = new PoolFactory(address(poolImpl));
        MOCKUSDC = MockUSDC(new MockUSDC(6));
        MOCKNGNs = MockNGNs(new MockNGNs(6));

        // DEPLOY POOL
        POOL = SalvaPool(POOLFACTORY.deployPool());
        assertEq(POOL.getDeployer(), MAINDEPLOYER);

        // PROVIDE LIQUIDITY
        MOCKUSDC.approve(address(POOL), 500_000e6);
        MOCKNGNs.approve(address(POOL), 500_000e6);
        POOL.provideLiquidity(address(MOCKUSDC), 500_000e6);
        POOL.provideLiquidity(address(MOCKNGNs), 500_000e6);

        // UPDATE RATE
        POOL.updateBuyRate(INITIALBUYRATE);
        POOL.updateSellRate(INITIALSELLRATE);
    }
}
