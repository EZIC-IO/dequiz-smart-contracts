// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.20;

import {DeQuizNFT} from "../src/DeQuizNFT.sol";
import {Script, console} from "forge-std/Script.sol";

contract DeployToBaseSepolia is Script {
    function setUp() public {}

    function run() public {
        uint256 devPrivateKey = vm.envUint("DEV_PRIVATE_KEY");
        address account = vm.addr(devPrivateKey);

        console.log("Dev Account", account);
        vm.startBroadcast(devPrivateKey);
        // Deploy DeQuizNFT
        new DeQuizNFT("Test_DQNFT_1", "TDQNFT1", account);
        vm.stopBroadcast();
    }
}
