// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import {Test, console2} from "forge-std/Test.sol";
import {OurToken} from "../src/OurToken.sol";
import {DeployERC20} from "../script/DeployERC20.s.sol";

contract OurTokenTest is Test {
    OurToken public ourToken;

    address bob = makeAddr("Bob");
    address alice = makeAddr("Alice");

    uint256 public constant STARTING_BALANCE = 10 ether;

    function setUp() public {
        DeployERC20 deployer = new DeployERC20();
        ourToken = deployer.deployERC20();

        vm.prank(msg.sender);
        ourToken.transfer(bob, STARTING_BALANCE);
    }

    function testBobBalance() public view {
        assertEq(ourToken.balanceOf(bob), STARTING_BALANCE, "Bob balance");
    }
}
