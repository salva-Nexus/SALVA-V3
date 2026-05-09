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
        // address multsigproxyMainnet = 0xd2611e3acE93303052478af5EE5d13e2E9c63C7A;
        address multsigProxyTestnet = 0x361A059ae5ef356f70DD535dc3f5A7db59350Ec6;
        SalvaPool poolImpl = new SalvaPool();
        PoolFactory factory = new PoolFactory();
        bytes memory data =
            abi.encodeWithSelector(PoolFactory.initialize.selector, poolImpl, multsigProxyTestnet);
        PoolFactory factoryProxy = PoolFactory(address(new ERC1967Proxy(address(factory), data)));

        console.log("FACTORY PROXY: ", address(factoryProxy));
    }
}
