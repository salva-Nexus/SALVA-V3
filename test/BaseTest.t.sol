// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { MockMultisig } from "@MockMultisig/MockMultisig.sol";
import { MockNGNs } from "@MockNGNs/MockNGNs.sol";
import { MockUSDC } from "@MockUSDC/MockUSDC.sol";
import { PoolFactory } from "@PoolFactory/PoolFactory.sol";
import { SalvaPool } from "@SalvaPool/SalvaPool.sol";
import { Test, console } from "forge-std/Test.sol";

abstract contract BaseTest is Test {
    PoolFactory internal POOLFACTORY;
    address internal MAINDEPLOYER;
    MockMultisig internal MULTISIG;
    uint256 internal DEPLOYERKEY;
    MockUSDC internal MOCKUSDC;
    MockNGNs internal MOCKNGNs;
    SalvaPool internal POOL;
    uint256 internal INITIALBUYRATE = 1500e6;
    uint256 internal INITIALSELLRATE = 1563_250000;

    function _changePrank(address _newPrank) internal {
        vm.stopPrank();
        vm.startPrank(_newPrank);
    }
}
