// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { DeployPool } from "@DeployPool/DeployPool.sol";
import { MockNGNs } from "@MockNGNs/MockNGNs.sol";
import { MockUSDC } from "@MockUSDC/MockUSDC.sol";
import { Test, console } from "forge-std/Test.sol";

abstract contract BaseTest is Test {
    address internal MAINDEPLOYER;
    uint256 internal DEPLOYERKEY;
    MockUSDC internal MOCKUSDC;
    MockNGNs internal MOCKNGNs;
    DeployPool internal POOL;
    uint256 internal INITIALBUYRATE = 1547_500000; // 1547.5 NGN per USD
    uint256 internal INITIALSELLRATE = 1563_250000; // 1563.25 NGN per USD

    function _changePrank(address _newPrank) internal {
        vm.stopPrank();
        vm.startPrank(_newPrank);
    }
}
