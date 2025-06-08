// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

contract Wallet {
    error Wallet__NotOwner();
    error Wallet__NotEnoughFunds();

    address public owner;

    event Deposit(address indexed sender, uint256 amount);

    constructor() payable {
        owner = payable(msg.sender);
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }

    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert Wallet__NotOwner();
        }
        _;
    }

    function withdraw(uint256 _amount) public onlyOwner {
        if (address(this).balance < _amount) {
            revert Wallet__NotEnoughFunds();
        }
        payable(msg.sender).transfer(_amount);
    }

    function setOwner(address _owner) external onlyOwner {
        owner = payable(_owner);
    }
}
