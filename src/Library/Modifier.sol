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

    modifier onlySupportedNgnDecimal(address token) {
        _onlySupportedNgnDecimal(token);
        _;
    }

    function _whenNotPaused() internal view {
        if (paused) {
            revert Errors__Not_Authorized();
        }
    }

    function _requireUninitialized() internal view {
        if (initialized) {
            revert Errors__AlreadyInitialized();
        }
    }

    function _onlyDeployer() internal view {
        if (_msgSender() != deployer) {
            revert Errors__Not_Authorized();
        }
    }

    // This is important as this pool only assumes NGN tokens with 6 decimals,
    // so we need to ensure that any token used as NGN has the correct decimals to avoid any issues
    // with the calculations
    function _onlySupportedNgnDecimal(address token) internal view {
        uint8 decimal = _decimalsOf(token);
        if (decimal != NGN_DECIMALS) {
            revert Errors__Unsupported_Ngn_Token(token);
        }
    }
}

