// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Test, console2} from "forge-std/Test.sol";
import {DeployImport} from "../script/DeployImport.s.sol";
import {Token} from "../src/Imports.sol";

contract TestImports is Test {
    Token public token;

    function setUp() external {
        DeployImport deployer = new DeployImport();
        token = deployer.run();
        assertTrue(address(token) != address(0), "Token not deployed");
        console2.log("Token address:", address(token));
    }

    function testTokenName() public view {
        assertEq(token.name(), "name", "Token name mismatch");
    }

    function testTokenSymbol() public view {
        assertEq(token.symbol(), "symbol", "Token symbol mismatch");
    }

    function testTokenDecimals() public view {
        assertEq(token.decimals(), 18, "Token decimals mismatch");
    }
}
