//SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Event} from "../src/Events.sol";
import {Test} from "forge-std/Test.sol";

contract TestEvent is Test {
    Event event_;

    event Transfer(address indexed from, address indexed to, uint256 value);

    function setUp() external {
        event_ = new Event();
    }

    function testEmitTransferEvent() external {
        // 1. Tell Foundry which data to check. Max 3 topics can be indexed and the rest of the data to check. Since the Transfer event has only 2 topics indexed,
        vm.expectEmit(true, true, false, true);

        // 2. Emit the expected event
        emit Transfer(address(this), address(123), 111);

        // 3. Call the Function that should emit the event.
        event_.transfer(address(this), address(123), 111);
    }

    function testEmitTransferManyEvent() external {
        address[] memory to = new address[](2);
        to[0] = address(123);
        to[1] = address(456);

        uint256[] memory amounts = new uint256[](2);
        amounts[0] = 111;
        amounts[1] = 222;

        vm.expectEmit(true, true, false, true);

        for (uint256 i = 0; i < to.length; i++) {
            emit Transfer(address(this), to[i], amounts[i]);
        }

        event_.transferMany(address(this), to, amounts);
    }
}
