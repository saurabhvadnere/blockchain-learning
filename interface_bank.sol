// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Bank{
    uint public totalBalance;

    function deposit (uint amount) external {
    totalBalance += amount;
    }

    function getbalance () external {
    }
}
