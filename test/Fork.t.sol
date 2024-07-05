//SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";

interface IWETH {
    function deposit() external payable;
    function balanceOf(address) external view returns (uint);
}

contract ForkTest is Test {
    IWETH public weth;

    function setUp() public {
        weth = IWETH(0xC02aaA39b223FE8D0A0e5C4F27eAD9083C756Cc2);
    }

    function testWethDeposit() public {
        uint256 balBefore = weth.balanceOf(address(this));
        console.log("Balance before deposit: %d", balBefore);
        weth.deposit{value: 100}();
        uint256 balAfter = weth.balanceOf(address(this));
        console.log("Balance after deposit: %d", balAfter);
    }
}