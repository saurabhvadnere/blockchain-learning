// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleWallet {

    // Stores how much Ether each user has deposited
    mapping(address => uint) public balance;

    // Event to track deposits on blockchain
    event Deposit(address indexed user, uint amount);

    // Function to deposit Ether into the contract
    function depo() public payable {
        // Ensure some Ether is sent
        require(msg.value > 0, "send some ether");

        // Update sender's balance
        balance[msg.sender] += msg.value;

        // Emit deposit event
        emit Deposit(msg.sender, msg.value);
    }

    // Returns total Ether stored in the contract
    function get_contract_bal() public view returns (uint) {
        return address(this).balance;
    }

    // Returns Ether balance of the caller
    function mybal() public view returns (uint) {
        return balance[msg.sender];
    }
}
