// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {IERC20} from "../src/interfaces/IERC20.sol";

contract Whale is Test {
    IERC20 public dai;

    function setUp() public {
        dai = IERC20(0x6B175474E89094C44Da98b954EedeAC495271d0F);
    }

    function testDaiDeposit() public {
        address alice = address(123);

        uint256 balBefore = dai.balanceOf(alice);
        console.log("Balance before deposit: %d", balBefore / 1e18);

        uint256 totalBefore = dai.totalSupply();
        console.log("Total supply before deposit: %d", totalBefore / 1e18);

        deal(address(dai), alice, 1e6 * 1e18, true);

        uint256 balAfter = dai.balanceOf(alice);
        console.log("Balance after deposit: %d", balAfter / 1e18);

        uint256 totalAfter = dai.totalSupply();
        console.log("Total supply after deposit: %d", totalAfter / 1e18);
    }
}