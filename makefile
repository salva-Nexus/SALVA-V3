include .env

DEPLOY-TO-BASE_MAINNET:
	forge script script/DeployFactory.s.sol:DeployFactory --rpc-url ${BASE_MAINNET_RPC_URL} --account mainKey --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

DEPLOY-TO-BASE_TESTNET:
	forge script script/DeployFactory.s.sol:DeployFactory --rpc-url ${BASE_SEPOLIA_RPC_URL} --account mainKey --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

DEPLOY-IMPL-TESTNET:
	forge script script/DeployPool.s.sol:DeployPool --rpc-url ${BASE_SEPOLIA_RPC_URL} --account mainKey --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY}

DEPLOY-IMPL-TESTNET1:
	forge script script/DeployPool.s.sol:DeployPool --rpc-url ${BASE_SEPOLIA_RPC_URL} --private-key 0x15eede1b5e4e834b6cc83913ebfc9aeb37238d0dd8c3556178910a4052edb1f1 --broadcast --verify --etherscan-api-key ${ETHERSCAN_API_KEY}
