// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SalarySlip {
    uint public basic = 40000;
    uint public DA = 2000;

    // Calculate TA (10% of basic)
    function getTA() public view returns (uint) {
        return basic * 10 / 100;
    }

    // Calculate HRA (30% of basic)
    function getHRA() public view returns (uint) {
        return basic * 30 / 100;
    }

    // Calculate PF (10% of basic but at least 3000)
    function getPF() public view returns (uint) {
        uint pf = basic * 10 / 100;
        if (pf < 3000) {
            return 3000;
        }
        return pf;
    }

    // Calculate Gross Salary (sum of all earnings)
    function getGrossSalary() public view returns (uint) {
        return basic + getTA() + DA + getHRA();
    }

    // Calculate Net Salary (Gross Salary - PF)
    function getNetSalary() public view returns (uint) {
        return getGrossSalary() - getPF();
    }
}
