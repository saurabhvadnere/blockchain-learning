// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Salary_manager {

    struct all_detail{
        string name;
        uint salary;
        uint increment;
        uint pf;
        uint tds;
    }

    mapping(address => all_detail) public employee_address;

    function set_details(string memory name, uint salary, uint increment) public{
        employee_address[msg.sender] = all_detail(name, salary + increment, increment,0,0);
    }
    
    function get_details() public view returns(string memory, uint, uint, uint){
        all_detail memory emp = employee_address[msg.sender];

        uint bonus = (emp.salary * 5) / 100;   // 5% bonus
        uint hra = (emp.salary * 40) / 100; 
        return(emp.name, emp.salary, bonus, hra);
    }

    function deductions() public returns(uint pf, uint tds){
        all_detail storage emp = employee_address[msg.sender];
        pf = (emp.salary * 12) / 100;  
        tds = (emp.salary * 7) / 100;

        emp.salary = emp.salary - (pf + tds);

        emp.pf = pf;
        emp.tds = tds;
    }
}