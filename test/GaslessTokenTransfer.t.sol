// SPDX-License-Identifier: MIT

pragma solidity ^0.8.20;

import {Test, console} from "forge-std/Test.sol";
import {GaslessTokenTransfer} from "../src/GaslessTokenTransfer.sol";
import {ERC20Permit} from "../src/ERC20Permit.sol";
import {DeployGaslessTokenTransfer} from "../script/DeployGaslessToken.s.sol";
import {DeployERC20Permit} from "../script/DeployERC20Permit.s.sol";

contract GaslessTokenTransferTest is Test {
    ERC20Permit private token;
    GaslessTokenTransfer private gaslessToken;

    uint256 constant SENDER_PRIVATE_KEY = 123;
    address sender;
    address receiver;
    uint256 constant AMOUNT = 1000;
    uint256 constant FEE = 100;

    function setUp() public {
        sender = vm.addr(SENDER_PRIVATE_KEY);
        receiver = address(2);
        // token = new ERC20Permit("Test", "Test", 18);
        DeployERC20Permit deployerERC20Permit = new DeployERC20Permit();
        token = deployerERC20Permit.deployERC20Permit();
        token.mint(sender, AMOUNT + FEE);
        // gaslessToken = new GaslessTokenTransfer();
        DeployGaslessTokenTransfer deployer = new DeployGaslessTokenTransfer();
        gaslessToken = deployer.deployGaslessTokenTransfer();
    }

    function testValidSig() public {
        uint256 deadline = block.timestamp + 60;

        // Prepare permit signature
        bytes32 permitHash = _getPermitHash(sender, address(gaslessToken), AMOUNT + FEE, token.nonces(sender), deadline);
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(SENDER_PRIVATE_KEY, permitHash);
        // Execute Send
        gaslessToken.send(address(token), sender, receiver, AMOUNT, FEE, deadline, v, r, s);
        //Check token balances
        assertEq(token.balanceOf(sender), 0, "sender balance");
        assertEq(token.balanceOf(receiver), AMOUNT, "receiver balance");
        assertEq(token.balanceOf(address(this)), FEE, "fee balance");
    }

    function _getPermitHash(address owner, address spender, uint256 value, uint256 nonce, uint256 deadline)
        private
        view
        returns (bytes32)
    {
        return keccak256(
            abi.encodePacked(
                "\x19\x01",
                token.DOMAIN_SEPARATOR(),
                keccak256(
                    abi.encode(
                        keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)"),
                        owner,
                        spender,
                        value,
                        nonce,
                        deadline
                    )
                )
            )
        );
    }
}
