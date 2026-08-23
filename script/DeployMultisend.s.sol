// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { SalvaMultisend } from "../src/SalvaMultisend.sol";
import { Script } from "forge-std/Script.sol";
import { console } from "forge-std/console.sol";

contract DeployMultisend is Script {
    function run() external {
        vm.startBroadcast();
        _deploy();
        vm.stopBroadcast();
    }

    function _deploy() internal {
        SalvaMultisend multisend = new SalvaMultisend();
        console.log("Chainid: ", block.chainid, "Multisend: ", address(multisend));
    }
}
