// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { MockNGNs } from "@MockNGNs/MockNGNs.sol";
import { MockUSDC } from "@MockUSDC/MockUSDC.sol";
import { PoolFactory } from "@PoolFactory/PoolFactory.sol";
import { SalvaPool } from "@SalvaPool/SalvaPool.sol";
import { Test } from "forge-std/Test.sol";

contract Target is Test {
    PoolFactory internal POOLFACTORY;
    address internal MERCHANT;
    address internal BUYER;
    MockUSDC internal MOCKUSDC;
    MockNGNs internal MOCKNGNs;
    SalvaPool internal DEPLOYEDPOOL;
    uint256 internal INITIALBUYRATE;
    uint256 internal INITIALSELLRATE;

    constructor(
        PoolFactory _POOLFACTORY,
        address _MERCHANT,
        address _BUYER,
        MockUSDC _MOCKUSDC,
        MockNGNs _MOCKNGNs,
        SalvaPool _DEPLOYEDPOOL,
        uint256 _INITIALBUYRATE,
        uint256 _INITIALSELLRATE
    ) {
        POOLFACTORY = _POOLFACTORY;
        MERCHANT = _MERCHANT;
        BUYER = _BUYER;
        MOCKUSDC = _MOCKUSDC;
        MOCKNGNs = _MOCKNGNs;
        DEPLOYEDPOOL = _DEPLOYEDPOOL;
        INITIALBUYRATE = _INITIALBUYRATE;
        INITIALSELLRATE = _INITIALSELLRATE;
    }

    function pickFunction(uint256 _randomNumber) external {
        _randomNumber = bound(_randomNumber, 1, type(uint256).max);
        _changePrank(MERCHANT);
        // UPDATE RATE
        DEPLOYEDPOOL.updateBuyRate(INITIALBUYRATE);
        _buyUSDC();
    }

    function _buyUSDC() internal {
        // We just use one user for all swaps
        uint256 poolUsdcBalance = MOCKUSDC.balanceOf(address(DEPLOYEDPOOL));
        if (poolUsdcBalance == 0) {
            return;
        }

        uint256 usdAmountOut;
        if (poolUsdcBalance / 3 == 0 && poolUsdcBalance != 0) {
            usdAmountOut = poolUsdcBalance;
        } else {
            usdAmountOut = poolUsdcBalance / 3;
        }

        uint256 NgnsToSell_FromBuyer = DEPLOYEDPOOL.getExactNGNAmountIn(
            address(MOCKUSDC), usdAmountOut, INITIALBUYRATE
        );
        if (NgnsToSell_FromBuyer == 0) {
            return;
        }

        _changePrank(BUYER);
        MOCKNGNs.approve(address(DEPLOYEDPOOL), NgnsToSell_FromBuyer);
        DEPLOYEDPOOL.swapExactNGNAmountForUSD(
            BUYER, address(MOCKUSDC), address(MOCKNGNs), NgnsToSell_FromBuyer
        );
    }

    function _changePrank(address _newPrank) internal {
        vm.stopPrank();
        vm.startPrank(_newPrank);
    }
}
