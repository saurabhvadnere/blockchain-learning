// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./interface_bank.sol";

contract Atm {
    Bank bank;
    constructor (address bank_address){
        bank = Bank(bank_address);
    }
    
    function add_money (uint _amount) public {
        bank.deposit(_amount);
    }  
}