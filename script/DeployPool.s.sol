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
        // address factoryProxyTestnet = 0xa92c375095c815908A6A0466c355432b084c3650;
        // address pool = 0xf41d790A358Dab9E2dd2edEfBf79d0ADE7f3c560;
        // address ngnsTestnet = 0xae7597fa3414Bc94254fA7777663882355ED6Cb7;
        // address usdcTestnet = 0x036CbD53842c5426634e7929541eC2318f3dCF7e;
        // address pool = PoolFactory(factoryProxyTestnet).deployPool();
        // console.log("POOL: ", pool);

        // IERC20(ngnsTestnet).approve(pool, type(uint256).max);
        // IERC20(usdcTestnet).approve(pool, type(uint256).max);
    }
}
