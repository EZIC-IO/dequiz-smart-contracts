// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {DeQuizNFT} from "../src/DeQuizNFT.sol";
import {Script, console} from "forge-std/Script.sol";

contract DeployToBaseMainnet is Script {
    function setUp() public {}

    function run() public {
        uint256 devPrivateKey = vm.envUint("DEV_PRIVATE_KEY");
        address account = vm.addr(devPrivateKey);

        console.log("Dev Account", account);
        vm.startBroadcast(devPrivateKey);
        // Deploy DeQuizNFT
        // >> TODO: Add bash parameter to deploy script or env and parse it here
        new DeQuizNFT("DeQuiz I", "DQZ-E01", account, "ipfs://CID");
        vm.stopBroadcast();
    }
}
