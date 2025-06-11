// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Error} from "../src/Error.sol";
import {Test} from "forge-std/Test.sol";
import {DeployError} from "../script/DeployError.s.sol";

contract TestError is Test {
    Error public error;

    function setUp() external {
        DeployError deployer = new DeployError();
        error = deployer.deployError();
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

    function testErrorLabel() public pure {
        assertEq(uint256(1), uint256(1), "test 1");
        assertEq(uint256(1), uint256(1), "test 2");
        assertEq(uint256(1), uint256(1), "test 3");
        assertEq(uint256(1), uint256(1), "test 4");
    }
}
