// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Test} from "forge-std/Test.sol";
import {Auction} from "../src/Time.sol";

contract TimeTest is Test {
    Auction auction;
    uint256 public startAt;

    function setUp() external {
        auction = new Auction();
        startAt = block.timestamp;
    }

    function testBidFailsBeforeStart() external {
        vm.expectRevert(bytes("Auction is not active"));
        auction.bid();
    }

    function testBid() public {
        vm.warp(startAt + 1 days);
        auction.bid();
    }

    function testBidAfterEndAt() public {
        vm.expectRevert(bytes("Auction is not active"));
        vm.warp(startAt + 2 days);
        auction.bid();
    }

    function testTimestamp() public {
        uint256 t = block.timestamp;
        skip(100);
        assertEq(block.timestamp, t + 100);

        rewind(10);
        assertEq(block.timestamp, t + 100 - 10);
    }

    function testBlockNumber() public {
        uint256 b = block.number;
        vm.roll(999);
        assertEq(block.number, 999);
    }
}
