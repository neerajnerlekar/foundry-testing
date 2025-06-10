// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Error} from "../src/Error.sol";
import {Script} from "forge-std/Script.sol";

contract DeployError is Script {
    function deployError() public returns (Error) {
        vm.startBroadcast();
        Error error = new Error();
        vm.stopBroadcast();
        return error;
    }

    function run() external {
        deployError();
    }
}
