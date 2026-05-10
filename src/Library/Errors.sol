// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { PoolStorage } from "@PoolStorage/PoolStorage.sol";

abstract contract Errors is PoolStorage {
    error Errors__Invalid_Rate(uint256);
    error Errors__Amount_Too_Low(uint256);
    error Errors__Not_Authorized();
    error Errors__Invalid_Swap_Token();
    error Errors__AlreadyInitialized();
}
