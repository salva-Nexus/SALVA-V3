// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/// @title SalvaMultisend
/// @notice Minimal batch-transaction executor
contract SalvaMultisend {
    /// @notice Thrown when the three input arrays don't have matching lengths.
    error LengthMismatch();

    /// @notice Thrown when a sub-call reverts.
    /// @param index Which transaction in the batch failed (0-indexed)
    error SubCallFailed(uint256 index);

    /// @notice Executes a batch of calls. Intended to be called via
    /// `delegatecall` from a Safe/MultiSig-style contract so each sub-call
    /// runs with msg.sender == the calling contract, not this one. A normal
    /// (non-delegatecall) invocation will run each sub-call with
    /// msg.sender == this contract's own address instead.
    /// @param to Target address for each call
    /// @param value Native token value to send with each call
    /// @param data Calldata for each call
    function multiSend(address[] calldata to, uint256[] calldata value, bytes[] calldata data)
        external
        payable
    {
        uint256 len = to.length;
        if (len != value.length || len != data.length) revert LengthMismatch();

        for (uint256 i = 0; i < len; i++) {
            (bool success,) = to[i].call{ value: value[i] }(data[i]);
            if (!success) revert SubCallFailed(i);
        }
    }
}
