// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { Context } from "@Context/Context.sol";
import { PoolHelper } from "@PoolHelper/PoolHelper.sol";

abstract contract Modifier is Context, PoolHelper {
    modifier whenNotPaused() {
        _whenNotPaused();
        _;
    }

    modifier onlyUninitialized() {
        _requireUninitialized();
        _;
    }

    modifier onlyDeployer() {
        _onlyDeployer();
        _;
    }

    function _whenNotPaused() internal view {
        if (PAUSED) {
            revert Errors__Not_Authorized();
        }
    }

    function _requireUninitialized() internal view {
        if (_initialized) {
            revert Errors__AlreadyInitialized();
        }
    }

    function _onlyDeployer() internal view {
        if (_msgSender() != DEPLOYER) {
            revert Errors__Not_Authorized();
        }
    }
}

