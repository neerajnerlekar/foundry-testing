// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Auction {
    uint256 public startAt = block.timestamp + 1 days;
    uint256 public endAt = block.timestamp + 2 days;

    function bid() external view {
        require(block.timestamp >= startAt && block.timestamp < endAt, "Auction is not active");
    }

    function end() external view {
        require(block.timestamp > endAt, "Auction is not ended");
    }
}
