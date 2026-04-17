// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank {
    address public owner;
    uint public minLoanAmount = 1 ;
    uint public maxLoanAmount = 10;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only bank owner allowed");
        _;
    }
}
