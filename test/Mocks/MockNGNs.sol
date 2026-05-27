// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import { ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

/**
 * @title MockNGNs
 * @dev Minimal ERC20 for Salva testing.
 * Note: USDC uses 6 decimals, so we override the default 18.
 */
contract MockNGNs is ERC20 {
  uint8 private immutable _decimals;

  constructor(uint8 decimals_) ERC20("Mock NGNs", "mNGNs") {
    _decimals = decimals_;
    _mint(msg.sender, 1_000_000e6);
  }

  function decimals() public view virtual override returns (uint8) {
    return _decimals;
  }

  function mint(address to, uint256 amount) external {
    _mint(to, amount);
  }
}
