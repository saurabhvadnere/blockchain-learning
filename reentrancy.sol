// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VulnerableBank {
    mapping(address => uint) public balance;
    // Deposit Ether
    function deposit() public payable {
        balance[msg.sender] += msg.value;
    }
    //  Vulnerable withdraw function
    function withdraw(uint _amount) public {
        require(balance[msg.sender] >= _amount, "Not enough balance");

        // Send Ether FIRST (danger)
        (bool sent, ) = msg.sender.call{value: _amount}("");
        require(sent, "Failed");

        // Update balance AFTER sending
        balance[msg.sender] -= _amount;
    }
}
