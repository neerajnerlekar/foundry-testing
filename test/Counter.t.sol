// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Counter} from "../src/Counter.sol";
import {Test, stdError} from "forge-std/Test.sol";

contract TestCounter is Test {
    Counter counter;

    function setUp() external {
        counter = new Counter();
    }

    function test_Inc() public {
        counter.inc();
        assertEq(counter.count(), 1);
    }

    function testFail_Dec() public {
        counter.dec();
    }

    function testDecUnderFlow() public {
        vm.expectRevert(stdError.arithmeticError);
        counter.dec();
    }

    function testDec() public {
        counter.inc();
        counter.inc();
        counter.dec();
        assertEq(counter.count(), 1);
    }
}
