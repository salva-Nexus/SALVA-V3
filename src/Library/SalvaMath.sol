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

    function calculateExactNGNsAmountIn(uint256 _tokenAmountOut, uint256 _exRate, uint256 _factor)
        internal
        pure
        returns (uint256 _amountIn)
    {
        _amountIn = (_exRate * _tokenAmountOut) / _factor;
    }

    function calculateExactTokenAmountIn(uint256 _ngnsAmountOut, uint256 _exRate, uint256 _factor)
        internal
        pure
        returns (uint256 _amountIn)
    {
        return (_ngnsAmountOut * _factor) / _exRate;
    }
}
