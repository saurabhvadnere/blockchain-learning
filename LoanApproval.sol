// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./Bank.sol";

contract LoanApproval is Bank {

    struct Loan {
        address user;
        uint amount;
        bool approved;
    }

    Loan[] public loans;

    // Event emitted when loan is approved
    event LoanApproved(address indexed user, uint amount, uint loanId);

    // Apply for a loan
    function applyLoan(uint _amount) public {
        require(
            _amount >= minLoanAmount && _amount <= maxLoanAmount,
            "Invalid loan amount"
        );

        loans.push(Loan({
            user: msg.sender,
            amount: _amount,
            approved: false
        }));
    }

    // Approve loan (only bank owner)
    function approveLoan(uint _loanId) public onlyOwner {
        require(_loanId < loans.length, "Invalid loan ID");
        require(!loans[_loanId].approved, "Already approved");

        loans[_loanId].approved = true;

        emit LoanApproved(
            loans[_loanId].user,
            loans[_loanId].amount,
            _loanId
        );
    }

    // Get total loans count
    function getTotalLoans() public view returns (uint) {
        return loans.length;
    }
}