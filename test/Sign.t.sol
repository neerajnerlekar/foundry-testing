// SPDX-License-Identifier: MIT

pragma solidity ^0.8.24;

import {Test, console} from "forge-std/Test.sol";

contract SignTest is Test {
    // private key
    // public key = vm.addr(privateKey)
    // message = "hello"
    // message hash = keccak256(message)
    // vm.sign(privateKey, message hash)

    function testSignature() public {
        uint256 privateKey = 123;
        address publicKey = vm.addr(privateKey);

        bytes32 messageHash = keccak256("hello");
        bytes32 invalidMessageHash = keccak256("invalid message");
        (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHash);
        // (uint8 v, bytes32 r, bytes32 s) = vm.sign(privateKey, messageHash);

        address signer = ecrecover(invalidMessageHash, v, r, s);
        // assertEq(signer, publicKey);
        assertTrue(signer != publicKey);
    }
}
