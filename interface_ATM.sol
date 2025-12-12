// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./UserBank.sol";

contract SBI_ATM {
    UserBank bank; 
    // IMPORTANT: We are connecting this ATM contract to an already deployed UserBank contract.
    // The 'bank' variable stores the address of the UserBank so ATM can call its functions.

    constructor(address bank_address) {
        bank = UserBank(bank_address); 
    }
    
    function Add_Cash (uint _amount) public {
        // IMPORTANT: This function does NOT hold money inside ATM contract.
        // It simply forwards the call to the UserBank contract.
        bank.deposit(_amount);  
    }

    function withdraw_Amount (uint _amount) public {
        // This calls the withdraw function from UserBank
        bank.withdraw_cash(_amount);
    }

    function Available_Balance () public view returns (uint) {
        // Reads balance directly from UserBank contract
        return bank.Get_Balance(); 
    }
}
