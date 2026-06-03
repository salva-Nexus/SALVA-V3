// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

import { ISalvaPool } from "@ISalvaPool/ISalvaPool.sol";
import { Modifier } from "@Modifier/Modifier.sol";

abstract contract SalvaOracle is Modifier, ISalvaPool {
    function updateBuyRate(uint256 _exRate) external onlyDeployer returns (bool) {
        uint256 oldRate = uint256(buyRate);
        // disable-next-line(unsafe-typecast)
        buyRate = uint128(_exRate);
        emit BuyRateUpdated(oldRate, _exRate);
        return true;
    }

    function updateSellRate(uint256 _exRate) external onlyDeployer returns (bool) {
        uint256 oldRate = uint256(sellRate);
        // disable-next-line(unsafe-typecast)
        sellRate = uint128(_exRate);
        emit SellRateUpdated(oldRate, _exRate);
        return true;
    }

    function _getBuyRate() public view returns (uint256) {
        return uint256(buyRate);
    }

    function _getSellRate() public view returns (uint256) {
        return uint256(sellRate);
    }
}
