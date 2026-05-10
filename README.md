<div align="center">

<br />

### **Salva V3 — On-Chain Naira Liquidity Pool**
*Permissionless NGN ↔ USDC/USDT Exchange Infrastructure*

<br />

[![Network](https://img.shields.io/badge/Network-Base_L2-0052FF?style=for-the-badge&logo=coinbase)](https://base.org)
[![Language](https://img.shields.io/badge/Stack-Solidity_|_Foundry-363636?style=for-the-badge&logo=ethereum)](https://soliditylang.org)
[![License](https://img.shields.io/badge/License-MIT-D4AF37?style=for-the-badge)](./LICENSE)

<br />

> **V3 introduces an on-chain liquidity pool for the Nigerian Naira.** LPs fund a pool once and earn automatically — no OTC desk, no merchant approval, no waiting.

<br />

</div>

---

## 📋 Table of Contents

- [The Problem](#-the-problem)
- [The Solution](#-the-salva-v3-solution)
- [Why V3 is Different](#-why-v3-is-different)
- [How It Works](#️-how-it-works)
- [Contract Architecture](#️-contract-architecture)
- [Deployments](#-deployments)
- [Developer Installation](#️-developer-installation)
- [License](#️-license)

---

## 💡 The Problem

The entire Nigerian crypto market runs on P2P — Binance P2P, Bybit P2P, LocalBitcoins. Every single one requires a merchant to be online, accept the order, confirm payment, and manually release crypto. The whole flow can take 10–30 minutes minimum. If the merchant is slow or offline, you are stuck.

The deeper problem is that NGN cannot be traded on any AMM. AMMs determine price algorithmically from pool ratios — but the Naira exchange rate is set by the real-world fiat market, not on-chain supply and demand. The moment an AMM pool is funded with NGNs, arbitrageurs can drain it instantly by exploiting the gap between the on-chain price and the actual fiat rate. The pool breaks before it can serve a single real user.

Salva V3 solves this with an oracle-gated model. The LP sets the rate manually from the live market, and the pool executes swaps at exactly that rate — no algorithmic pricing, no arbitrage surface, no pool drain.

---

## ✨ The Salva V3 Solution

Salva V3 is an on-chain P2P liquidity pool that enables instant, permissionless exchange between **NGNs** (Nigerian Naira stablecoin) and **USDC / USDT** on Base.

LPs fund their pool once, set their rates, and go to sleep. The pool executes swaps automatically — 24/7, on-chain, with no intermediary and no off-chain backend involved.

---

## 🌟 Why V3 is Different

### ⚡ Fully Automated

No merchant needs to be online. No order book. No chat. No waiting. The pool executes the swap the moment it is called — any time of day, any day of the year.

### 🔐 Non-Custodial by Design

Funds live in the pool contract, not on any backend. The LP retains full ownership and can withdraw at any time. No Safe relay, no multisig approval, no backend private key involved in swap execution.

---

## 🗺️ How It Works

### 1. Pool Deployment

Each LP deploys their own isolated pool clone via the `PoolFactory`. The factory deploys an EIP-1167 minimal proxy of `SalvaPool` and initializes it with the caller as the deployer.

```
PoolFactory.deployPool()
  → deploys EIP-1167 SalvaPool clone
  → initializes with msg.sender as DEPLOYER
  → returns pool address
```

### 2. LP Funds the Pool

The LP transfers NGNs and USDC/USDT directly into the pool. There is no internal share accounting at this stage — `availableLiquidity` reads `balanceOf(address(this))` directly.

### 3. User Swaps

Four swap functions are available depending on whether the user knows their exact input or exact output:

```solidity
// Know exactly how much NGNs you want to spend
POOL.swapExactNGNAmountForToken(receiver, USDC, NGNs, 3095e6)

// Know exactly how much USDC you want to spend
POOL.swapExactTokenAmountForNGN(receiver, USDC, NGNs, 2e6)

// Know exactly how much USDC you want to receive
POOL.swapForExactTokenAmount(receiver, USDC, NGNs, 2e6)

// Know exactly how much NGNs you want to receive
POOL.swapForExactNGNAmount(receiver, USDC, NGNs, 3095e6)
```

### 4. Rate Convention

Rates are stored as `uint128` with 6 decimal precision.

---

## 🛠️ Contract Architecture

```
SalvaPool  (initialize, provideLiquidity, removeLiquidity)
└── SwapEngine  (swapExactNGNAmountForToken, swapExactTokenAmountForNGN,
│               swapForExactTokenAmount, swapForExactNGNAmount, pause, unpause)
    └── SalvaOracle  (updateBuyRate, updateSellRate, _getBuyRate, _getSellRate)
        └── Modifier  (onlyDeployer, whenNotPaused, onlyUninitialized)
            └── PoolHelper  (availableLiquidity, getDeployer,
            │               getExactTokenAmountOut, getExactNGNsAmountOut,
            │               getExactNGNsAmountIn, getExactTokenAmountIn,
            │               _onlySupportedToken)
                └── PoolStorage  (S_FACTOR, SUPPORTED_TOKEN_DECIMAL, DEPLOYER, PAUSED, rates)

PoolFactory  (UUPS proxy — deploys EIP-1167 SalvaPool clones, MultiSig controlled)
SalvaMath   (calculateTokenAmountOut, calculateNGNsAmountOut,
             calculateExactNGNsAmountIn, calculateExactTokenAmountIn)
```

### Contract Summary

| Contract | Responsibility |
| :--- | :--- |
| `SalvaPool` | Entry point. Initialize, fund, withdraw. |
| `SwapEngine` | Core swap logic and emergency controls. |
| `SalvaOracle` | On-chain buy/sell rate management. |
| `PoolHelper` | View helpers and token validation. |
| `SalvaMath` | Fixed-point exchange rate math. |
| `Modifier` | Access control and state guards. |
| `PoolStorage` | Shared state layout. |
| `PoolFactory` | UUPS factory — deploys and tracks pool clones. |

---

## 🌍 Deployments

| Network | Purpose |
| :--- | :--- |
| **Base L2** | Salva native wallet — low gas |

---

## 🖥️ Developer Installation

### Prerequisites

- [Foundry](https://book.getfoundry.sh/getting-started/installation)

### Setup

```bash
git clone https://github.com/salva-Nexus/SALVA-V3.git
cd SALVA-V3
forge install
forge build
```

### Testing

```bash
# Run all tests
forge test

# Run with verbose trace output
forge test -vvv

# Run a specific test
forge test --match-test testSwapExactAmountToToken -vvvv
```

---

## ⚖️ License

Distributed under the MIT License. See [`LICENSE`](./LICENSE) for more information.

---

<div align="center">

Built on [Base](https://base.org) &nbsp;·&nbsp; On-Chain Naira Swap Pool &nbsp;·&nbsp; (https://salva-nexus.org)

</div>