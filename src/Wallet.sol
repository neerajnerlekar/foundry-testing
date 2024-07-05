// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Wallet {
    address public owner;

    event Deposit(address indexed sender, uint256 amount);

    constructor() payable {
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount) public {
        require(msg.sender == owner, "You are not the owner");
        require(address(this).balance >= _amount, "Not enough funds");
        payable(msg.sender).transfer(_amount);
    }

    function setOwner(address _owner) external {
        require(msg.sender == owner, "caller is not owner");
        owner = payable(_owner);
    }
}
