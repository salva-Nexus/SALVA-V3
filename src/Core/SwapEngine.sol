// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { SalvaOracle } from "@SalvaOracle/SalvaOracle.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

abstract contract SwapEngine is SalvaOracle {
  using SafeERC20 for IERC20;

  function swapExactNGNAmountForUSD(
    address _receiver,
    address _usdTokenOut,
    address _ngnTokenIn,
    uint256 _ngnAmountIn
  ) public whenNotPaused returns (bool) {
    _onlySupportedToken(_usdTokenOut);
    _onlySupportedToken(_ngnTokenIn);
    if (_ngnAmountIn < _minNgnAmount) {
      revert Errors__Amount_Too_Low(_ngnAmountIn);
    }
    uint256 _exRate = _getBuyRate();
    if (_exRate == 0) {
      revert Errors__Invalid_Rate(_exRate);
    }
    uint256 usdAmountOut = getExactUSDAmountOut(_ngnAmountIn, _exRate);

    emit SwappedToUSD(_receiver, _usdTokenOut, _ngnAmountIn, usdAmountOut);
    return _executeSwap(_ngnTokenIn, _usdTokenOut, _receiver, _ngnAmountIn, usdAmountOut, false);
  }

  function swapExactUSDAmountForNGN(
    address _receiver,
    address _usdTokenIn,
    address _ngnTokenOut,
    uint256 _usdAmountIn
  ) public whenNotPaused returns (bool) {
    _onlySupportedToken(_usdTokenIn);
    _onlySupportedToken(_ngnTokenOut);
    if (_usdAmountIn < _minUsdAmount) {
      revert Errors__Amount_Too_Low(_usdAmountIn);
    }
    uint256 _exRate = _getSellRate();
    if (_exRate == 0) {
      revert Errors__Invalid_Rate(_exRate);
    }
    uint256 ngnAmountOut = getExactNGNAmountOut(_usdAmountIn, _exRate);
    emit SwappedToNGN(_receiver, _usdTokenIn, _usdAmountIn, ngnAmountOut);
    return _executeSwap(_ngnTokenOut, _usdTokenIn, _receiver, ngnAmountOut, _usdAmountIn, true);
  }

  function swapForExactUSDAmount(
    address _receiver,
    address _usdTokenOut,
    address _ngnTokenIn,
    uint256 _usdAmountOut
  ) external whenNotPaused returns (bool) {
    _onlySupportedToken(_usdTokenOut);
    _onlySupportedToken(_ngnTokenIn);
    uint256 _exRate = _getBuyRate();
    uint256 exactNGNAmountIn = getExactNGNAmountIn(_usdAmountOut, _exRate);
    if (exactNGNAmountIn < _minNgnAmount) {
      revert Errors__Amount_Too_Low(exactNGNAmountIn);
    }
    emit SwappedToUSD(_receiver, _usdTokenOut, exactNGNAmountIn, _usdAmountOut);
    return
      _executeSwap(_ngnTokenIn, _usdTokenOut, _receiver, exactNGNAmountIn, _usdAmountOut, false);
  }

  function swapForExactNGNAmount(
    address _receiver,
    address _usdTokenIn,
    address _ngnTokenOut,
    uint256 _ngnAmountOut
  ) external whenNotPaused returns (bool) {
    _onlySupportedToken(_usdTokenIn);
    _onlySupportedToken(_ngnTokenOut);
    uint256 _exRate = _getSellRate();
    uint256 exactUsdAmountIn = getExactUSDAmountIn(_ngnAmountOut, _exRate);
    if (exactUsdAmountIn < _minUsdAmount) {
      revert Errors__Amount_Too_Low(exactUsdAmountIn);
    }
    // uint256 swapNGNOut = getExactNGNAmountOut(exactUsdAmountIn, _exRate);
    emit SwappedToNGN(_receiver, _usdTokenIn, exactUsdAmountIn, _ngnAmountOut);
    return _executeSwap(_ngnTokenOut, _usdTokenIn, _receiver, _ngnAmountOut, exactUsdAmountIn, true);
  }

  function _executeSwap(
    address _ngnToken,
    address _usdToken,
    address _receiver,
    uint256 _ngnAmount,
    uint256 _usdAmount,
    bool _ngnOut
  ) internal returns (bool) {
    if (!_ngnOut) {
      IERC20(_ngnToken).safeTransferFrom(_msgSender(), address(this), _ngnAmount);
      IERC20(_usdToken).safeTransfer(_receiver, _usdAmount);
    } else {
      IERC20(_usdToken).safeTransferFrom(_msgSender(), address(this), _usdAmount);
      IERC20(_ngnToken).safeTransfer(_receiver, _ngnAmount);
    }
    return true;
  }
}
