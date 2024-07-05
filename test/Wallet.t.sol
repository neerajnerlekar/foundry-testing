// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";
import {Wallet} from "../src/Wallet.sol";

contract WalletTest is Test {
    Wallet wallet;

    uint256 public constant INITIAL_BALANCE = 10 ether;

    function setUp() public {
        wallet = new Wallet{value: INITIAL_BALANCE}();
        // wallet = new Wallet();
    }

    function _send(uint256 amount) private {
        (bool ok,) = address(wallet).call{value: amount}("");
        require(ok, "send failed");
    }

    function testEthBalance() public view {
        console.log("Eth Balance: %s", address(this).balance / 1e18);
        console.log("Wallet Balance: %s", address(wallet).balance / 1e18);
    }

    function testSendEth() public {
        uint256 walletBalance = address(wallet).balance;

        deal(address(1), 100 ether);
        assertEq(address(1).balance, 100 ether);

        hoax(address(1), 100 ether);
        _send(100 ether);
        assertEq(address(wallet).balance, walletBalance + 100 ether);
    }
}
