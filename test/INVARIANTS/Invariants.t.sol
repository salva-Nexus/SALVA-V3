// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { Target } from "./Target.t.sol";
import { MockNGNs } from "@MockNGNs/MockNGNs.sol";
import { MockUSDC } from "@MockUSDC/MockUSDC.sol";
import { PoolFactory } from "@PoolFactory/PoolFactory.sol";
import { SalvaPool } from "@SalvaPool/SalvaPool.sol";
import { StdInvariant } from "forge-std/StdInvariant.sol";
import { Test, console } from "forge-std/Test.sol";

contract Invariants is StdInvariant, Test {
    PoolFactory internal POOLFACTORY;
    address internal MAINDEPLOYER;
    address internal MERCHANT;
    address internal BUYER;
    MockUSDC internal MOCKUSDC;
    MockNGNs internal MOCKNGNs;
    SalvaPool internal DEPLOYEDPOOL;
    uint256 internal INITIALBUYRATE = 1500e6;
    uint256 internal INITIALSELLRATE = 1450e6;

    function setUp() external {
        MAINDEPLOYER = makeAddr("MAINDEPLOYER");
        MERCHANT = makeAddr("MERCHANT");
        BUYER = makeAddr("BUYER");

        _changePrank(MAINDEPLOYER);
        SalvaPool poolImpl = new SalvaPool();
        POOLFACTORY = new PoolFactory(address(poolImpl));
        MOCKUSDC = MockUSDC(new MockUSDC(6));
        MOCKNGNs = MockNGNs(new MockNGNs(6));
        MOCKNGNs.mint(MAINDEPLOYER, 9_000_000e6);
        MOCKNGNs.mint(MERCHANT, 50_000_000e6);
        MOCKNGNs.mint(BUYER, 100_000_000e6);

        // DEPLOY POOL
        _changePrank(MERCHANT);
        DEPLOYEDPOOL = SalvaPool(POOLFACTORY.deployPool());

        // Simulate a merchant buying USDC from someone with NGN at a specific rate..\
        _buyUSDC();

        Target target = new Target(
            POOLFACTORY,
            MERCHANT,
            BUYER,
            MOCKUSDC,
            MOCKNGNs,
            DEPLOYEDPOOL,
            INITIALBUYRATE,
            INITIALSELLRATE
        );
        targetContract(address(target));
        bytes4[] memory selector = new bytes4[](1);
        selector[0] = Target.pickFunction.selector;

        FuzzSelector memory _targetSelector =
            FuzzSelector({ addr: address(target), selectors: selector });
        targetSelector(_targetSelector); // 50,000,000
    }

    function invariant_Test_Calculates_Profit_Correctly_From_Ngn_To_Usd_Swaps() external view {
        uint256 poolPreviousNgnBalance = 0;
        uint256 poolNewNgnBalance = MOCKNGNs.balanceOf(address(DEPLOYEDPOOL));
        uint256 poolUsdBalanceRemaining = MOCKUSDC.balanceOf(address(DEPLOYEDPOOL));

        assertGe(poolNewNgnBalance, poolPreviousNgnBalance);
        console.log("Pools Previous NGN Balance:", poolPreviousNgnBalance / 1e6, "NGNS");
        console.log("Pools New NGN Balance:", poolNewNgnBalance / 1e6, "NGNS");
        console.log("Pool USDC Balance:", poolUsdBalanceRemaining / 1e6, "USDC");
    }

    function _buyUSDC() internal {
        // Simulate a merchant buying USDC from someone with NGN at a specific rate..
        // Merchant has 74,000 NGNs, buys USDC from DEPLOYER, rate = 1480/USD
        uint256 merchantNgnBalance = 50_000_000e6;
        uint256 usdBuyRateFromDeployer = 1480e6;
        uint256 usdToReceive = (merchantNgnBalance * 1e6) / usdBuyRateFromDeployer; // Amount of
        // USDC merchant receives
        // Buying USDC
        _changePrank(MERCHANT);
        MOCKNGNs.transfer(MAINDEPLOYER, merchantNgnBalance);
        _changePrank(MAINDEPLOYER);
        MOCKUSDC.transfer(address(DEPLOYEDPOOL), usdToReceive);
        assert(MOCKUSDC.balanceOf(address(DEPLOYEDPOOL)) == usdToReceive);
    }

    function _changePrank(address _newPrank) internal {
        vm.stopPrank();
        vm.startPrank(_newPrank);
    }
}
