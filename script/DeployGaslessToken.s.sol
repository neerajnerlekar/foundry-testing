// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {GaslessTokenTransfer} from "../src/GaslessTokenTransfer.sol";

contract DeployGaslessTokenTransfer is Script {
    function deployGaslessTokenTransfer() public returns (GaslessTokenTransfer) {
        vm.startBroadcast();
        GaslessTokenTransfer gaslessTokenTransfer = new GaslessTokenTransfer();
        vm.stopBroadcast();

        console2.log("GaslessTokenTransfer deployed at:", address(gaslessTokenTransfer));

        return gaslessTokenTransfer;
    }

    function run() external {
        deployGaslessTokenTransfer();
    }
}
