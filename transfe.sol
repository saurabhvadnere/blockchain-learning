// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Tranfer{
    
    function sendETH (address payable receiver, uint amount) public payable{
        receiver.transfer(amount);
    }
}