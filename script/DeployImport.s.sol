// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script, console2} from "forge-std/Script.sol";
import {Token} from "../src/Imports.sol";

contract DeployImport is Script {
    function deployImport() public returns (Token) {
        vm.startBroadcast();
        Token token = new Token();
        console2.log("Token deployed at:", address(token));
        vm.stopBroadcast();
        return token;
    }

    function run() external returns (Token) {
        return deployImport();
    }
}
