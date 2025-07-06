// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Auction} from "../src/Time.sol";
import {Script} from "forge-std/Script.sol";

contract DeployTime is Script {
    function deployTime() public returns (Auction) {
        vm.startBroadcast();
        Auction auction = new Auction();
        vm.stopBroadcast();
        return auction;
    }

    function run() external {
        deployTime();
    }
}
