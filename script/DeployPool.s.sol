// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { PoolFactory } from "@PoolFactory/PoolFactory.sol";
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
        // address factoryProxyTestnet = 0xe953D2A484B9b83E90A5b409Af5c80E653Cb2eaF;
        // address pool1 = 0x480732BB15dDe38c894E36f62523Da01eD5e4054;
        // address ngnsTestnet = 0xae7597fa3414Bc94254fA7777663882355ED6Cb7;
        // address usdcTestnet = 0x036CbD53842c5426634e7929541eC2318f3dCF7e;
        // address pool = PoolFactory(factoryProxyTestnet).deployPool();
        // console.log("POOL: ", pool);
        //
    }
}
