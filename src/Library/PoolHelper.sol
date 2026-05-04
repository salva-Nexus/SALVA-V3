// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { Errors } from "@Errors/Errors.sol";
import { IERC20Metadata } from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";

abstract contract PoolHelper is Errors {
    function _onlySupportedToken(address _token) internal view {
        uint256 tokenDecimal = IERC20Metadata(_token).decimals();
        if (tokenDecimal != SUPPORTED_TOKEN_DECIMAL) {
            revert Errors__Invalid_Swap_Token();
        }
    }
}
