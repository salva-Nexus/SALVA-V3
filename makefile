include .env

DEPLOY-TO-BASE_MAINNET:
	forge script script/DeployFactory.s.sol:DeployFactory --rpc-url ${BASE_MAINNET_RPC_URL} --account mainKey --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

DEPLOY-TO-BASE_TESTNET:
	forge script script/DeployFactory.s.sol:DeployFactory --rpc-url ${BASE_SEPOLIA_RPC_URL} --account mainKey --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

DEPLOY-IMPL-TESTNET:
	forge script script/DeployPool.s.sol:DeployPool --rpc-url ${BASE_SEPOLIA_RPC_URL} --account mainKey --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY}


DEPLOY-IMPL-TESTNET1:
	forge script script/DeployPool.s.sol:DeployPool --rpc-url ${BASE_SEPOLIA_RPC_URL} --account mainKey2 --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

DEPLOY-TO-ETH_MAINNET:
	forge script script/DeployFactory.s.sol:DeployFactory --rpc-url ${ETH_MAINNET_RPC_URL} --account mainKey --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

DEPLOY-TO-SEPOLIA_TESTNET:
	forge script script/DeployFactory.s.sol:DeployFactory --rpc-url ${ETH_SEPOLIA_RPC_URL} --account mainKey --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY}