// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Calculator {

    function multi (uint num1, uint num2) external pure returns (uint){
        return num1*num2;
    }
    function divi (uint num1, uint num2) external pure returns (uint){
        return (num1*100)/num2;
    }
    function sub (uint num1, uint num2) external pure returns (uint){
        return num1-num2;
    }
    function add (uint num1, uint num2) external pure returns (uint){
        return num1+num2;
    }
    function modu (uint num1, uint num2) external pure returns (uint){
        return num1%num2;
    }
}

contract Calculator {

    uint public number = 10;

    function add(uint a, uint b) public view  returns(uint){
       
        return a + b + number;
    }

    function subtract(uint a, uint b) public pure returns(uint){
        return a - b;
    }

    function getNumber() public view returns(uint){
        return block.timestamp;
    }

}