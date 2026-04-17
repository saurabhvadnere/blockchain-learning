// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    UserBank Contract
    - Stores balance per user
    - Allows deposit & withdrawal of real Ether
*/

contract UserBank {

    // stores balance of each user
    mapping(address => uint256) private balances;

    // deposit real Ether
    function deposit() external payable {
        require(msg.value > 0, "Add some money");
        balances[msg.sender] += msg.value;
    }

    // withdraw caller's own balance
    function withdraw_cash(uint256 amount) external {
        require(amount <= balances[msg.sender], "Insufficient balance");
        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    // get caller's balance
    function Get_Balance() external view returns (uint256) {
        return balances[msg.sender];
    }
}
