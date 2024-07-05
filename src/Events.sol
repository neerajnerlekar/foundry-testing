// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Event {
    event Transfer(address indexed from, address indexed to, uint256 value);

    function transfer(address from, address to, uint256 value) public {
        emit Transfer(from, to, value);
    }

    function transferMany(address from, address[] calldata to, uint256[] calldata values) public {
        require(to.length == values.length, "to and values length mismatch");
        for (uint256 i = 0; i < to.length; i++) {
            emit Transfer(from, to[i], values[i]);
        }
    }
}
