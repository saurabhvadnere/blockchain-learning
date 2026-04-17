// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Mycalc{
    uint256 public result=0;
    function add(uint256 val) public {
        result+=val;
        result = val + result;
    }
    function sub(uint256 val) public {
        result-=val;
    }
    function mul(uint256 val) public {
        result*=val;
    }
}