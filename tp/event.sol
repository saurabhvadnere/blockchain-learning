// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract EventExample {

    // Declare event
    event MoneyDeposited(address indexed sender, uint amount);

    function deposit() public payable {
        // Emit event

        
        emit MoneyDeposited(msg.sender, msg.value);
    }
}
