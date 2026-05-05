// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { Errors } from "@Errors/Errors.sol";
import { MockUSDC } from "@MockUSDC/MockUSDC.sol";
import { Setup } from "@Setup/Setup.t.sol";

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
        POOL.swapExactAmountToNGNs(user, address(mUSD), address(MOCKNGNs), 200e6);
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
        MOCKUSDC.transfer(user, 200e6);
        _changePrank(user);
        MOCKUSDC.approve(address(POOL), 200e6);
        vm.expectRevert(Errors.Errors__Not_Authorized.selector);
        POOL.swapExactAmountToNGNs(user, address(MOCKUSDC), address(MOCKNGNs), 200e6);

        _changePrank(MAINDEPLOYER);
        POOL.unpause();

        // should work
        _changePrank(user);
        POOL.swapExactAmountToNGNs(user, address(MOCKUSDC), address(MOCKNGNs), 200e6);
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
        POOL.swapExactAmountToToken(user, address(MOCKUSDC), address(MOCKNGNs), amount);

        uint256 expected = POOL.getExactTokenOut(amount, POOL._getBuyRate());

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
        POOL.swapExactAmountToNGNs(user, address(MOCKUSDC), address(MOCKNGNs), amount);

        uint256 expected = POOL.getExactNGNsOut(amount, POOL._getSellRate());

        assertEq(MOCKUSDC.balanceOf(user), 2_000e6 - amount);
        assertEq(MOCKNGNs.balanceOf(user), expected);
    }
}
