// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { PoolFactory } from "@PoolFactory/PoolFactory.sol";
import { SalvaPool } from "@SalvaPool/SalvaPool.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/Test.sol";

contract DeployPool is Script {
    modifier deploy() {
        vm.startBroadcast();
        _;
        vm.stopBroadcast();
    }

    function run() external deploy {
        // address baseTestnetfactory =
        // 0x514B96ffD40c4B13eD43a2c8A2a9F6a74157126D;
        // address bscTestnetFactory =
        // 0xBbf66d8c2f871cfEff45317b1Db26E3D83afB22C;
        // address ngnsBaseTestnet = 0xae7597fa3414Bc94254fA7777663882355ED6Cb7;
        // address usdcBaseTestnet = 0x036CbD53842c5426634e7929541eC2318f3dCF7e;

        // address pool =
        // PoolFactory(baseTestnetfactory).deployPool();
        // console.log("POOL: ", pool);
        // console.log("POOL IMPL: ",
        // address(poolImpl));
    }
}
