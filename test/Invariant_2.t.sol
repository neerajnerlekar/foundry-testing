// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {WETH} from "../src/WETH.sol";

import {CommonBase} from "forge-std/Base.sol";
import {StdCheats} from "forge-std/StdCheats.sol";
import {StdUtils} from "forge-std/StdUtils.sol";

contract Handler is CommonBase, StdCheats, StdUtils {
    WETH private wEth;
    uint public wEthBalance;

    constructor(WETH _wEth) {
        wEth = _wEth;
    }

    receive() external payable {}

    function sendToFallback(uint256 amount) public {
        amount = bound(amount, 0, address(this).balance);
        wEthBalance += amount;
        (bool success, ) = address(wEth).call{value: amount}("");
        require(success, "sendToFallback: failed");        
    }

    function deposit(uint256 amount) public {
        amount = bound(amount, 0, address(this).balance);
        wEthBalance += amount;
        wEth.deposit{value: amount}();
    }

    function withdraw(uint256 amount) public {
        amount = bound(amount, 0, wEth.balanceOf(address(this)));
        wEthBalance -= amount;
        wEth.withdraw(amount);
    }
}

contract WETH_Handle_Based_Invariant_Test is Test {
    WETH public wEth;
    Handler public handler;

    function setUp() public {
        wEth = new WETH();
        handler = new Handler(wEth);

        deal(address(handler), 100 * 1e18);
        targetContract(address(handler));
    }

    function invariant_eth_balance() public view {
            assertGe(address(wEth).balance, handler.wEthBalance());
        }
}