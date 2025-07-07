// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {OurToken} from "../src/OurToken.sol";

contract DeployERC20 is Script {
    uint256 public constant INITIAL_SUPPLY = 1000 ether;

    function deployERC20() public returns (OurToken) {
        vm.startBroadcast();
        OurToken token = new OurToken(INITIAL_SUPPLY);
        vm.stopBroadcast();

        console2.log("ERC20 deployed at:", address(token));

        return token;
    }

    function run() external {
        deployERC20();
    }
}
