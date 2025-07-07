// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Script, console2} from "forge-std/Script.sol";
import {ERC20Permit} from "../src/ERC20Permit.sol";

contract DeployERC20Permit is Script {
    string public constant NAME = "TestToken";
    string public constant SYMBOL = "TTK";
    uint8 public constant DECIMALS = 18;

    function deployERC20Permit() public returns (ERC20Permit) {
        vm.startBroadcast();
        ERC20Permit token = new ERC20Permit(NAME, SYMBOL, DECIMALS);
        vm.stopBroadcast();
        console2.log("ERC20Permit deployed at:", address(token));

        return token;
    }

    function run() external {
        deployERC20Permit();
    }
}
