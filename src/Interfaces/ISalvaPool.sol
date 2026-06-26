// SPDX-License-Identifier: MIT
pragma solidity ^0.8.30;

/**
 * @title ISalvaPool
 * @notice Full interface for Salva V3 P2P Pools handling swaps, rates,
 * liquidity, and emergency
 * states.
 */
interface ISalvaPool {
    // --- Swap Events ---
    event SwappedToUSD(
        address indexed receiver, address indexed token, uint256 ngnAmountIn, uint256 usdAmountOut
    );

    event SwappedToNGN(
        address indexed receiver, address indexed token, uint256 usdAmountIn, uint256 ngnAmountOut
    );

    // --- Rate Events ---
    event BuyRateUpdated(uint256 newRate);
    event SellRateUpdated(uint256 newRate);

    // --- State Events ---
    event Paused(address account);
    event Unpaused(address account);

    // --- Liquidity Events ---
    event LiquidityAdded(address indexed asset, uint256 amount);
    event LiquidityRemoved(address indexed asset, uint256 amount);

    event MinimumNgnAmountSet(uint256 amount);
    event MinimumUsdAmountSet(uint256 amount);

    // --- Swap Functions (Input-Centric) ---
    function swapExactNGNAmountForUSD(
        address _receiver,
        address _usdTokenOut,
        address _ngnTokenIn,
        uint256 _ngnAmountIn
    ) external returns (bool);

    function swapExactUSDAmountForNGN(
        address _receiver,
        address _usdTokenIn,
        address _ngnTokenOut,
        uint256 _usdAmountIn
    ) external returns (bool);

    // --- Swap Functions (Output-Centric) ---
    /**
     * @notice Swap variable NGNs for an exact
     * amount of stablecoins/tokens.
     */
    function swapForExactUSDAmount(
        address _receiver,
        address _usdTokenOut,
        address _ngnTokenIn,
        uint256 _usdAmountOut
    ) external returns (bool);

    /**
     * @notice Swap variable stablecoins/tokens
     * for an exact amount of NGNs.
     */
    function swapForExactNGNAmount(
        address _receiver,
        address _usdTokenIn,
        address _ngnTokenOut,
        uint256 _ngnAmountOut
    ) external returns (bool);

    // --- Initialization ---
    function initialize(address deployer) external;
}
