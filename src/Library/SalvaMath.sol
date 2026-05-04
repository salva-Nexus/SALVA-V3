// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

library SalvaMath {
    function calculateTokenAmountOut(uint256 _amountIn, uint256 _exRate, uint256 _factor)
        internal
        pure
        returns (uint256 _amountOut)
    {
        _amountOut = (_amountIn * _factor) / _exRate;
    }

    function calculateNGNsAmountOut(uint256 _amountIn, uint256 _exRate, uint256 _factor)
        internal
        pure
        returns (uint256 _amountOut)
    {
        _amountOut = (_amountIn * _exRate) / _factor;
    }
}
