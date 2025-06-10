// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Wallet} from "../src/Wallet.sol";
import {Test, console2} from "forge-std/Test.sol";
import {DeployWallet} from "../script/DeployWallet.s.sol";

contract TestAuth is Test {
    Wallet public wallet;

    function setUp() public {
        DeployWallet deployer = new DeployWallet();
        wallet = deployer.deployWallet();
        // wallet = new Wallet();
    }

    function testSetOwner() public {
        // if Deploy script is used, the owner is the deployer
        vm.prank(msg.sender);

        // otherwise, the owner is the address that created the contract
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

    function testFailModifierOnlyOwner() public {
        vm.expectRevert("Wallet__NotOwner()");
        wallet.withdraw(1 ether);
    }

    function testWithdraw() public {
        hoax(address(wallet), 2 ether);
        uint256 initialBalance = address(wallet).balance;
        uint256 withdrawAmount = 1 ether;
        console2.log("Initial Wallet Balance: %s", initialBalance / 1e18);

        vm.startPrank(wallet.owner());
        wallet.withdraw(withdrawAmount);
        vm.stopPrank();

        assertEq(address(wallet).balance, initialBalance - withdrawAmount);
    }

    function testFailWithdrawNotEnoughFunds() public {
        vm.startPrank(wallet.owner());
        wallet.withdraw(address(wallet).balance + 1 ether);
        vm.stopPrank();
    }

    function testFailWithdrawNotOwner() public {
        vm.startPrank(address(1));
        wallet.withdraw(1 ether);
        vm.stopPrank();
    }
}
