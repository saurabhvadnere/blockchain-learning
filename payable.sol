// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleWallet {

    address public owner;

    // Constructor sets the owner
    constructor() {
        owner = msg.sender;
    }

    //  Payable function to receive Ether
    function deposit() public payable {
        // msg.value contains the amount of Ether sent
    }

    //  Check contract balance
    function getBalance() public view returns (uint) {
        return address(this).balance;
    }

    // Withdraw Ether (only owner)
    function withdraw(uint amount) public {
        require(msg.sender == owner, "Not owner");
        require(amount <= address(this).balance, "Insufficient balance");

        payable(owner).transfer(amount);
    }
}