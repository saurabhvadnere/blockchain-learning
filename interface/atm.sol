// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
 Interface defines ONLY the functions
 that exist in UserBank and that ATM needs.
*/
interface IUserBank {
    function deposit() external payable;
    function withdraw_cash(uint256 amount) external;
    function Get_Balance() external view returns (uint256);
}

/*
 SBI_ATM Contract
 - Acts as a middle layer between user and bank
*/
contract SBI_ATM {

    IUserBank public bank;

    constructor(address bank_address) {
        bank = IUserBank(bank_address);
    }

    // deposit Ether via ATM
    function Add_Cash() external payable {
        bank.deposit{value: msg.value}();
    }

    // withdraw own funds via ATM
    function withdraw_Amount(uint256 amount) external {
        bank.withdraw_cash(amount);
    }

    // check own balance via ATM
    function Available_Balance() external view returns (uint256) {
        return bank.Get_Balance();
    }
}
