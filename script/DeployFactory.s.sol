// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { PoolFactory } from "@PoolFactory/PoolFactory.sol";
import { SalvaPool } from "@SalvaPool/SalvaPool.sol";
import { ERC1967Proxy } from "@openzeppelin/contracts/proxy/ERC1967/ERC1967Proxy.sol";
import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/Test.sol";

contract DeployFactory is Script {
  modifier deploy() {
    vm.startBroadcast();
    _;
    vm.stopBroadcast();
  }

  function run() external {
    _deployFactory();
  }

  function _deployFactory() internal deploy {
    SalvaPool poolImpl = new SalvaPool();
    PoolFactory factory = new PoolFactory(address(poolImpl));

    console.log("FACTORY: ", address(factory));
  }
}
