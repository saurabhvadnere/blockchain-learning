// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserBank{

    event Depo (address indexed Owner, uint _amount);
    uint TotalBalance; 
    // IMPORTANT: This variable stores the TOTAL balance inside the bank contract.
    // It does NOT track individual user balances. This is a shared pool.

    function deposit (uint amount) external {
        require(amount > 0, "Add Some Money");
        TotalBalance += amount;

        emit Depo(msg.sender,amount);
    }

    function withdraw_cash (uint _amount) external {
        require(_amount <= TotalBalance, "Insufficient fund");
        TotalBalance -= _amount;
    }

    function Get_Balance () external view returns (uint){
        return TotalBalance;   
    }
}
