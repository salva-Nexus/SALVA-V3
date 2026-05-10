// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title ISalvaPool
 * @notice Full interface for Salva V3 P2P Pools handling swaps, rates, liquidity, and emergency
 * states.
 */
interface ISalvaPool {
    event RoutingPoolUpdated(address indexed pool);
    // --- Swap Events ---
    event SwappedToToken(
        address indexed receiver, address indexed token, uint256 ngnsIn, uint256 tokenOut
    );

    event SwappedToNGNs(
        address indexed receiver, address indexed token, uint256 tokenIn, uint256 ngnsOut
    );

    // --- Rate Events ---
    event BuyRateUpdated(uint256 oldRate, uint256 newRate);
    event SellRateUpdated(uint256 oldRate, uint256 newRate);

    // --- State Events ---
    event Paused(address account);
    event Unpaused(address account);

    // --- Liquidity Events ---
    event LiquidityAdded(address indexed asset, uint256 amount);
    event LiquidityRemoved(address indexed asset, uint256 amount);

    event MinimumNgnAmountSet(uint256 amount);
    event MinimumTokenAmountSet(uint256 amount);

    // --- Swap Functions ---
    function swapExactNGNAmountForToken(
        address _receiver,
        address _swapTokenOut,
        address _ngnsToken,
        uint256 _ngnsAmountIn
    ) external returns (bool);

    function swapExactTokenAmountForNGN(
        address _receiver,
        address _swapTokenIn,
        address _ngnsTokenOut,
        uint256 _tokenAmountIn
    ) external returns (bool);

    // --- Rate Management ---
    function updateBuyRate(uint256 _exRate) external returns (bool);
    function updateSellRate(uint256 _exRate) external returns (bool);

    // --- Liquidity Management ---
    function provideLiquidity(address asset, uint256 amount) external returns (bool);
    function removeLiquidity(address asset, uint256 amount) external returns (bool);

    // --- Initialization ---
    function initialize(address deployer) external;

    // --- Emergency Control ---
    function pause() external returns (bool);
    function unpause() external returns (bool);
}
