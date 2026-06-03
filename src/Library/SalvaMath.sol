// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

library SalvaMath {
    function calculateUSDAmountOut(uint256 _amountIn, uint256 _exRate, uint256 _factor)
        internal
        pure
        returns (uint256 _amountOut)
    {
        _amountOut = (_amountIn * _factor) / _exRate;
    }

    function calculateNGNAmountOut(uint256 _amountIn, uint256 _exRate, uint256 _factor)
        internal
        pure
        returns (uint256 _amountOut)
    {
        _amountOut = (_amountIn * _exRate) / _factor;
    }

    function calculateExactNGNAmountIn(uint256 _usdAmountOut, uint256 _exRate, uint256 _factor)
        internal
        pure
        returns (uint256 _amountIn)
    {
        _amountIn = (_exRate * _usdAmountOut) / _factor;
    }

    function calculateExactUSDAmountIn(uint256 _ngnAmountOut, uint256 _exRate, uint256 _factor)
        internal
        pure
        returns (uint256 _amountIn)
    {
        return (_ngnAmountOut * _factor) / _exRate;
    }

    function scaleDown(uint256 _amount, uint256 _factor) internal pure returns (uint256) {
        return _amount / _factor;
    }
}
