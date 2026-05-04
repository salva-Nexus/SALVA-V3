// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { Context } from "@Context/Context.sol";
import { PoolHelper } from "@PoolHelper/PoolHelper.sol";

abstract contract Modifier is Context, PoolHelper {
    modifier onlyTreasurer(address _treasurer) {
        _onlyTreasurer(_treasurer);
        _;
    }

    modifier onlyMultisig(address _multisig) {
        _onlyMultisig(_multisig);
        _;
    }

    modifier whenNotPaused(bool _state) {
        _whenNotPaused(_state);
        _;
    }

    modifier onlyUninitialized(bool _isInitialized) {
        _requireUninitialized(_isInitialized);
        _;
    }

    modifier onlyDeployer(address _deployer) {
        _onlyDeployer(_deployer);
        _;
    }

    function _onlyTreasurer(address _treasurer) internal view {
        if (_msgSender() != _treasurer) {
            revert Errors__Not_Authorized();
        }
    }

    function _onlyMultisig(address _multisig) internal view {
        if (_msgSender() != _multisig) {
            revert Errors__Not_Authorized();
        }
    }

    function _whenNotPaused(bool _state) internal pure {
        if (_state) {
            revert Errors__Not_Authorized();
        }
    }

    function _requireUninitialized(bool _isInitialized) internal pure {
        if (_isInitialized) {
            revert Errors__AlreadyInitialized();
        }
    }

    function _onlyDeployer(address _deployer) internal view {
        if (_msgSender() != _deployer) {
            revert Errors__Not_Authorized();
        }
    }
}

