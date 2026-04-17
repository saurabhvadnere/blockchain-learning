// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MappingDemo{

    mapping (address => uint) public balances;

    function setBalance(uint amount) public {
        balances[msg.sender]=amount;
    }

    function getMyBalance() public view returns(uint){
        return balances[msg.sender];
    }
}  