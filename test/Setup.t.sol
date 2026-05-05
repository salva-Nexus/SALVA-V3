// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { BaseTest } from "@BaseTest/BaseTest.t.sol";
import { DeployPool } from "@DeployPool/DeployPool.sol";
import { MockNGNs } from "@MockNGNs/MockNGNs.sol";
import { MockUSDC } from "@MockUSDC/MockUSDC.sol";

abstract contract Setup is BaseTest {
    function setUp() external {
        MAINDEPLOYER = makeAddr("MAINDEPLOYER");

        _changePrank(MAINDEPLOYER);
        MOCKUSDC = MockUSDC(new MockUSDC(6));
        MOCKNGNs = MockNGNs(new MockNGNs(6));

        // DEPLOY POOL
        POOL = new DeployPool();
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
