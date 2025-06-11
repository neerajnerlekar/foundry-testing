// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Event} from "../src/Events.sol";
import {Script} from "forge-std/Script.sol";

contract DeployEvent is Script {
    function deployEvent() public returns (Event) {
        vm.startBroadcast();
        Event eventContract = new Event();
        vm.stopBroadcast();
        return eventContract;
    }

    function run() external {
        deployEvent();
    }
}
