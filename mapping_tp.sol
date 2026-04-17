// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract SimpleWallet {
    // Store deposited Ether for each user
    mapping(address => uint) public balances;
    // Events
    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);
    // event Received(address sender, uint amount);
    // event FallbackCalled(address sender, uint amount, bytes data);

    // 1️Deposit Ether (payable function)
    function deposit() public payable {
        require(msg.value > 0, "Send some Ether");

        balances[msg.sender] += msg.value;

        emit Deposited(msg.sender, msg.value);
    }
    // 2️Withdraw using TRANSFER (auto reverts on failure)
    function withdrawUsingTransfer(uint amount,address sencond_PERSON) public {
        require(balances[msg.sender] >= amount, "Not enough balance");

        balances[msg.sender] -= amount;
        payable(sencond_PERSON).transfer(amount);

        emit Withdrawn(msg.sender, amount);
    }
}