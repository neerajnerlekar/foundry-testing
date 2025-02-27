// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Error} from "../src/Error.sol";
import {Test} from "forge-std/Test.sol";

contract TestError is Test {
    Error error;

    function setUp() external {
        error = new Error();
    }

    function testFail() public view {
        error.throwError();
    }

    function testRevert() public {
        vm.expectRevert();
        error.throwError();
    }

    function testRequireMessage() public {
        vm.expectRevert(bytes("This is an error message"));
        error.throwError();
    }

    function testCustomError() public {
        vm.expectRevert(Error.NotAuthorized.selector);
        error.throwCustomError();
    }

    function testErrorLabel() public {
        assertEq(uint256(1), uint256(1), "test 1");
        assertEq(uint256(1), uint256(1), "test 2");
        assertEq(uint256(1), uint256(1), "test 3");
        assertEq(uint256(1), uint256(1), "test 4");
    }
}
