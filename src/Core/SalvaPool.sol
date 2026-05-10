// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { SwapEngine } from "@SwapEngine/SwapEngine.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract SalvaPool is SwapEngine {
    using SafeERC20 for IERC20;

    function initialize(address deployer) external onlyUninitialized {
        DEPLOYER = deployer;
        _initialized = true;
        PAUSED = false;
    }

    /**
     * @notice Allows LP to fund the pool.
     * @dev Emits LiquidityAdded for off-chain tracking.
     */
    function provideLiquidity(address asset, uint256 amount) external returns (bool) {
        // Transfer assets from the LP's wallet to this pool contract
        IERC20(asset).safeTransferFrom(_msgSender(), address(this), amount);

        // EMIT EVENT
        emit LiquidityAdded(asset, amount);

        return true;
    }

    /**
     * @notice Allows LP to withdraw funds.
     * @dev Emits LiquidityRemoved for off-chain tracking.
     */
    function removeLiquidity(address asset, uint256 amount) external onlyDeployer returns (bool) {
        // Transfer assets from the pool contract back to the LP's wallet
        IERC20(asset).safeTransfer(_msgSender(), amount);

        // EMIT EVENT
        emit LiquidityRemoved(asset, amount);

        return true;
    }
}
