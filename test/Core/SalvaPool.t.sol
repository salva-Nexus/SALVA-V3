// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { Errors } from "@Errors/Errors.sol";
import { MockUSDC } from "@MockUSDC/MockUSDC.sol";
import { Setup } from "@Setup/Setup.t.sol";
import { console } from "forge-std/Test.sol";

contract SalvaPool is Setup {
  function testSetup() external view {
    assertEq(MOCKUSDC.decimals(), 6);
    assertEq(MOCKNGNs.decimals(), 6);
    assertEq(MOCKUSDC.balanceOf(MAINDEPLOYER), 500_000e6);
    assertEq(MOCKNGNs.balanceOf(MAINDEPLOYER), 500_000e6);
    assertEq(POOL.availableLiquidity(address(MOCKUSDC)), 500_000e6);
    assertEq(POOL.availableLiquidity(address(MOCKNGNs)), 500_000e6);
    assertEq(POOL._getBuyRate(), INITIALBUYRATE);
    assertEq(POOL._getSellRate(), INITIALSELLRATE);
  }

  function testOnlySupportedToken() external {
    address user = makeAddr("user");
    _changePrank(MAINDEPLOYER);
    MockUSDC mUSD = MockUSDC(new MockUSDC(18));
    mUSD.transfer(user, 200e6);
    _changePrank(user);
    mUSD.approve(address(POOL), 200e6);
    vm.expectRevert(Errors.Errors__Invalid_Swap_Token.selector);
    POOL.swapExactUSDAmountForNGN(user, address(mUSD), address(MOCKNGNs), 200e6);
  }

  function testOnlyDeployerCanPauseAndUnpause(address _prank) external {
    vm.assume(_prank != MAINDEPLOYER);
    _changePrank(_prank);
    vm.expectRevert(Errors.Errors__Not_Authorized.selector);
    POOL.pause();

    _changePrank(MAINDEPLOYER);
    POOL.pause();

    _changePrank(_prank);
    vm.expectRevert(Errors.Errors__Not_Authorized.selector);
    POOL.unpause();
  }

  function testCannotSwapWhenPaused() external {
    _changePrank(MAINDEPLOYER);
    POOL.pause();

    address user = makeAddr("user");
    MOCKUSDC.transfer(user, 400e6);
    MOCKNGNs.transfer(user, 400_000e6);
    _changePrank(user);
    MOCKUSDC.approve(address(POOL), 200e6);
    MOCKNGNs.approve(address(POOL), POOL.getExactNGNAmountOut(150e6, POOL._getSellRate()));

    vm.expectRevert(Errors.Errors__Not_Authorized.selector);
    POOL.swapExactUSDAmountForNGN(user, address(MOCKUSDC), address(MOCKNGNs), 200e6);

    vm.expectRevert(Errors.Errors__Not_Authorized.selector);
    POOL.swapForExactUSDAmount(user, address(MOCKUSDC), address(MOCKNGNs), 200e6);

    _changePrank(MAINDEPLOYER);
    POOL.unpause();

    // should work
    _changePrank(user);
    POOL.swapExactUSDAmountForNGN(user, address(MOCKUSDC), address(MOCKNGNs), 200e6);
    POOL.swapForExactUSDAmount(user, address(MOCKUSDC), address(MOCKNGNs), 150e6);
  }

  function testSwapExactAmountToToken() external {
    address user = makeAddr("user");
    _changePrank(MAINDEPLOYER);
    MOCKNGNs.mint(user, 1_000_000e6);
    assertEq(MOCKNGNs.balanceOf(user), 1_000_000e6);
    assertEq(MOCKUSDC.balanceOf(user), 0);

    uint256 amount = 1547_500000 * 2;
    _changePrank(user);
    MOCKNGNs.approve(address(POOL), amount);
    POOL.swapExactNGNAmountForUSD(user, address(MOCKUSDC), address(MOCKNGNs), amount);

    uint256 expected = POOL.getExactUSDAmountOut(amount, POOL._getBuyRate());

    assertEq(MOCKNGNs.balanceOf(user), 1_000_000e6 - amount);
    assertEq(MOCKUSDC.balanceOf(user), expected);
  }

  function testSwapExactAmountToNGNs() external {
    address user = makeAddr("user");
    _changePrank(MAINDEPLOYER);
    MOCKUSDC.mint(user, 2_000e6);
    assertEq(MOCKUSDC.balanceOf(user), 2_000e6);
    assertEq(MOCKNGNs.balanceOf(user), 0);

    uint256 amount = 5e6;
    _changePrank(user);
    MOCKUSDC.approve(address(POOL), amount);
    POOL.swapExactUSDAmountForNGN(user, address(MOCKUSDC), address(MOCKNGNs), amount);

    uint256 expected = POOL.getExactNGNAmountOut(amount, POOL._getSellRate());

    assertEq(MOCKUSDC.balanceOf(user), 2_000e6 - amount);
    assertEq(MOCKNGNs.balanceOf(user), expected);
  }

  function testCannotSwapWhenRateNotSet() external {
    address user = makeAddr("user");
    _changePrank(MAINDEPLOYER);
    MOCKUSDC.mint(user, 2_000e6);
    // Set Rate to 0, simulate fresh deployed pool without setting rate...
    POOL.updateSellRate(0);

    uint256 amount = 5e6;
    _changePrank(user);
    MOCKUSDC.approve(address(POOL), amount);

    vm.expectRevert(abi.encodeWithSelector(Errors.Errors__Invalid_Rate.selector, 0));
    POOL.swapExactUSDAmountForNGN(user, address(MOCKUSDC), address(MOCKNGNs), amount);
  }

  function testSwapForExactUSDAmount() external {
    address user = makeAddr("user");
    _changePrank(MAINDEPLOYER);
    MOCKNGNs.mint(user, 1_000_000e6);
    assertEq(MOCKNGNs.balanceOf(user), 1_000_000e6);
    assertEq(MOCKUSDC.balanceOf(user), 0);

    uint256 amount = 2e6;
    _changePrank(user);
    MOCKNGNs.approve(address(POOL), type(uint256).max);
    POOL.swapForExactUSDAmount(user, address(MOCKUSDC), address(MOCKNGNs), amount);

    uint256 expected = POOL.getExactNGNAmountIn(amount, POOL._getBuyRate());

    assertEq(MOCKNGNs.balanceOf(user), 1_000_000e6 - expected);
    assertEq(MOCKUSDC.balanceOf(user), amount);
  }

  function testswapForExactNGNAmount() external {
    address user = makeAddr("user");
    _changePrank(MAINDEPLOYER);
    MOCKUSDC.mint(user, 2_000e6);
    assertEq(MOCKUSDC.balanceOf(user), 2_000e6);
    assertEq(MOCKNGNs.balanceOf(user), 0);

    uint256 amount = 1563_250000;
    _changePrank(user);
    MOCKUSDC.approve(address(POOL), type(uint256).max);
    POOL.swapForExactNGNAmount(user, address(MOCKUSDC), address(MOCKNGNs), amount);

    uint256 expected = POOL.getExactUSDAmountIn(amount, POOL._getSellRate());

    assertEq(MOCKUSDC.balanceOf(user), 2_000e6 - expected);
    assertEq(MOCKNGNs.balanceOf(user), amount);
  }

  function testOnlyDeployerCanCallProvideLiquidityFn(address _prank) external {
    vm.assume(_prank != MAINDEPLOYER);
    _changePrank(_prank);
    vm.expectRevert(Errors.Errors__Not_Authorized.selector);
    POOL.provideLiquidity(address(MOCKUSDC), 200_000e6);
  }

  function testOnlyDeployerCanRemoveLiquidity(address _prank) external {
    vm.assume(_prank != MAINDEPLOYER);
    _changePrank(_prank);
    vm.expectRevert(Errors.Errors__Not_Authorized.selector);
    POOL.removeLiquidity(address(MOCKUSDC), 200_000e6);
  }

  function testMinAmount() external {
    _changePrank(MAINDEPLOYER);
    POOL.setMinimumNgnAmount(5000e6);
    POOL.setMinimumTokenAmount(2e6);

    // NGN
    address user = makeAddr("user");
    MOCKNGNs.mint(user, 1_000_000e6);
    MOCKUSDC.mint(user, 2000e6);

    uint256 ngnAmount = 2000e6;
    _changePrank(user);
    MOCKNGNs.approve(address(POOL), ngnAmount);
    vm.expectRevert(abi.encodeWithSelector(Errors.Errors__Amount_Too_Low.selector, ngnAmount));
    POOL.swapExactNGNAmountForUSD(user, address(MOCKUSDC), address(MOCKNGNs), ngnAmount);

    // USD
    uint256 usdAmount = 1e6;
    _changePrank(user);
    MOCKUSDC.approve(address(POOL), usdAmount);
    vm.expectRevert(abi.encodeWithSelector(Errors.Errors__Amount_Too_Low.selector, usdAmount));
    POOL.swapExactUSDAmountForNGN(user, address(MOCKUSDC), address(MOCKNGNs), usdAmount);
  }
}
