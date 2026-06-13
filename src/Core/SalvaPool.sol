// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { SwapEngine } from "@SwapEngine/SwapEngine.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract SalvaPool is SwapEngine {
    using SafeERC20 for IERC20;

    function initialize(address _deployer) external onlyUninitialized {
        deployer = _deployer;
        initialized = true;
        paused = false;
    }

    /**
     * @notice Allows LP to fund the pool.
     * @dev Emits LiquidityAdded for off-chain
     * tracking.
     */
    function provideLiquidity(address asset, uint256 amount)
        external
        onlyDeployer
        returns (bool)
    {
        // Transfer assets from the LP's wallet
        // to this pool contract
        IERC20(asset).safeTransferFrom(_msgSender(), address(this), amount);

        // EMIT EVENT
        emit LiquidityAdded(asset, amount);

        return true;
    }

    /**
     * @notice Allows LP to withdraw funds.
     * @dev Emits LiquidityRemoved for off-chain
     * tracking.
     */
    function removeLiquidity(address asset, uint256 amount)
        external
        onlyDeployer
        returns (bool)
    {
        // Transfer assets from the pool
        // contract back to the LP's wallet
        IERC20(asset).safeTransfer(_msgSender(), amount);

        // EMIT EVENT
        emit LiquidityRemoved(asset, amount);

        return true;
    }

    function setMinimumNgnAmount(uint256 amount) external onlyDeployer returns (bool) {
        // disable-next-line(unsafe-typecast)
        minNgnAmount = uint128(amount);
        emit MinimumNgnAmountSet(amount);
        return true;
    }

    function setMinimumTokenAmount(uint256 amount) external onlyDeployer returns (bool) {
        // disable-next-line(unsafe-typecast)
        minUsdAmount = uint128(amount);
        emit MinimumUsdAmountSet(amount);
        return true;
    }

    /**
     * @notice Emergncy stop: Pauses all swap
     * functions in the pool.
     */
    function pause() external onlyDeployer returns (bool) {
        paused = true;
        emit Paused(_msgSender());
        return true;
    }

    /**
     * @notice Resume: Re-activates swap
     * functions.
     */
    function unpause() external onlyDeployer returns (bool) {
        paused = false;
        emit Unpaused(_msgSender());
        return true;
    }

    function VERSION() external pure returns (uint256) {
        return 3.0;
    }
}
