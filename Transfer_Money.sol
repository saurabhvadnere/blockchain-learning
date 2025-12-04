// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// A simple contract to manage token transfers with pause/unpause feature
contract Transfer {

    // Address of the contract owner
    address public owner;

    // Boolean to check if contract is paused or not
    bool public paused;

    // Mapping to store balances of each address
    mapping (address => uint) public bal;

    // Constructor runs only once, when contract is deployed
    constructor() {
        owner = msg.sender;    // msg.sender = account deploying the contract
        paused = false;        // Contract starts in unpaused state
        bal[owner] = 1000;     // Give the owner an initial balance of 1000 tokens
    }

    // Modifier to restrict certain functions only to the owner
    modifier onlyOwner() {
        require(msg.sender == owner, "Not allowed");
        _; // Continue execution
    }

    // Modifier to ensure function runs only when contract is NOT paused
    modifier notPaused() {
        require(!paused, "Transfer is Paused");
        _;
    }

    // Owner can pause the contract (stops transfers)
    function pause() public onlyOwner {
        paused = true;
    }

    // Owner can unpause the contract (allows transfers)
    function unPause() public onlyOwner {
        paused = false;
    }

    // Transfer tokens from sender to another address
    // Can run only when contract is not paused
    function transfer(address to, uint amt) public notPaused {

        // Check if sender has enough balance
        require(bal[msg.sender] >= amt, "Low in Balance");

        // Deduct amount from sender
        bal[msg.sender] -= amt;

        // Add amount to receiver
        bal[to] += amt;
    }
}
