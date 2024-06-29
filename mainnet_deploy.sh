#!/bin/bash

# Load env
source .env
# Simulate deployment
forge script script/DeployToBaseMainnet.s.sol:DeployToBaseMainnet --rpc-url https://mainnet.base.org && \
# Broadcast and verify the deployment
forge script script/DeployToBaseMainnet.s.sol:DeployToBaseMainnet --rpc-url https://mainnet.base.org --broadcast --verify -vvvv
