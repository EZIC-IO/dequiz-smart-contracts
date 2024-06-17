#!/bin/bash

# Load env
source .env
# Simulate deployment
forge script script/DeployToBaseSepolia.s.sol:DeployToBaseSepolia --rpc-url https://sepolia.base.org && \
# Broadcast and verify the deployment
forge script script/DeployToBaseSepolia.s.sol:DeployToBaseSepolia --rpc-url https://sepolia.base.org --broadcast --verify -vvvv
