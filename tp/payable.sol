// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Wallet {

    mapping(address => uint) public balances;

    function deposit() public payable {
        require(msg.value > 0, "Send some ETH");
        balances[msg.sender] += msg.value;
    }

    function myBalance() public view returns (uint) {
        return balances[msg.sender];
    }
}
