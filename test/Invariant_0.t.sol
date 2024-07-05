// SPDX-License-Identifier: MIT

pragma solidity 0.8.20;

contract IntroInvariant {
    bool public flag;

    function func_1() external {}
    function func_2() external {}
    function func_3() external {
        flag = true;
    }
    function func_4() external {}
    function func_5() external {
        
    }
}
import {Test, console} from "forge-std/Test.sol";

contract IntroInvariantTest is Test {
    IntroInvariant private introInvariant;

    function setUp() public {
        introInvariant = new IntroInvariant();
    }

    function invariant_flag_is_false() public view {
        assertEq(introInvariant.flag(), false);
    }
}

