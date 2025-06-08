// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console2} from "forge-std/Script.sol";
import {Wallet} from "../src/Wallet.sol";

contract DeployWallet is Script {
    function deployWallet() public returns (Wallet) {
        vm.startBroadcast();
        Wallet wallet = new Wallet();
        vm.stopBroadcast();

        console2.log("Wallet deployed at:", address(wallet));
        console2.log("Wallet owner:", wallet.owner());
        console2.log("Wallet balance:", address(wallet).balance / 1e18, "ETH");

        return wallet;
    }

    function run() external {
        deployWallet();
    }
}
