// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {WETH} from "../src/WETH.sol";

contract WETH_Open_Invariant_Test is Test {
    WETH public wEth;

    function setUp() public {
        wEth = new WETH();
    }

    function invariant_totalSupply_is_always_zero() public view {
        assertEq(wEth.totalSupply(), 0);
    }
}