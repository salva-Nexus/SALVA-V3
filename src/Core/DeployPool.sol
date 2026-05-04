// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { SalvaPool } from "@SalvaPool/SalvaPool.sol";
import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";


contract DeployPool is SalvaPool {
    using SafeERC20 for IERC20;

    function initialize() external onlyUninitialized(_initialized) {
        DEPLOYER = _msgSender();
        _initialized = true;
        PAUSED = false;
    }

    function provideLiquidity(address asset, uint256 amount) external onlyDeployer(DEPLOYER) returns (bool) {
        _onlySupportedToken(asset);
        
        // Transfer assets from the LP's wallet to this pool contract
        IERC20(asset).safeTransferFrom(_msgSender(), address(this), amount);
        
        return true;
    }

   
    function removeLiquidity(address asset, uint256 amount) external onlyDeployer(DEPLOYER) returns (bool) {
        _onlySupportedToken(asset);
        
        // Transfer assets from the pool contract back to the LP's wallet
        IERC20(asset).safeTransfer(_msgSender(), amount);
        
        return true;
    }
}