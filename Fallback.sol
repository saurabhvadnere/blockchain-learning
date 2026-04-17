// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Fallback{

// automatically runs when ether is send to contract, no data is send in transaction used to accept ether

    event Receive(address user, uint amount);

    event fallback_Call (address sender, uint amount, bytes data);

    // When ether is send with no data

    receive() external payable { 
        emit Receive (msg.sender, msg.value);
    }

    // when function does not exist 
    
    fallback() external payable {
        emit fallback_Call(msg.sender, msg.value, msg.data);
    }
}