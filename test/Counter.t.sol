// SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {Counter} from "../src/Counter.sol";
import {DeployCounter} from "../script/DeployCounter.s.sol";
import {Test, stdError} from "forge-std/Test.sol";

contract TestCounter is Test {
    Counter public counter;

    function setUp() external {
        DeployCounter deployer = new DeployCounter();
        counter = deployer.run();
        assertTrue(address(counter) != address(0), "Counter not deployed");
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
