// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Wallet} from "../src/Wallet.sol";
import {Test} from "forge-std/Test.sol";

contract TestAuth is Test {
    Wallet wallet;

    function setUp() public {
        wallet = new Wallet();
    }

    function testSetOwner() public {
        wallet.setOwner(address(1));
        assertEq(wallet.owner(), address(1));
    }

    function testFailNotOwner() public {
        vm.prank(address(1));
        wallet.setOwner(address(1));
    }

    function testFailSetOwnerAgain() public {
        wallet.setOwner(address(1));

        vm.startPrank(address(1));

        wallet.setOwner(address(1));
        wallet.setOwner(address(1));
        wallet.setOwner(address(1));

        vm.stopPrank();

        wallet.setOwner(address(1));
    }
}
