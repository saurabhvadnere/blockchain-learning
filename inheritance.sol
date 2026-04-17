// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// This is a parent contract
contract Employee{
    string public name;
    uint public salary;

    function setEmp(string memory _name, uint _salary) public {
        name = _name;
        salary = _salary;
    }   
}

// This is a child contract
contract Manager is Employee{
    string public job_role = "Manager";

    function print_detail () public view returns (string memory, uint, string memory){
        return (name,salary,job_role);
    }
}