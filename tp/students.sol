// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentManagement {

    struct Student {
        string name;
        uint age;
        uint marks;
        bool isPassed;
    }

    mapping(address => Student) public students;

    function addStudent(string memory _name, uint _age, uint _marks) public {

        bool passed;

        if(_marks >= 40){
            passed = true;
        } else {
            passed = false;
        }

        students[msg.sender] = Student(_name, _age, _marks, passed);
    }

    function getStudent(address user) public view returns(string memory, uint, uint, bool){
        Student memory s = students[user];
        return (s.name, s.age, s.marks, s.isPassed);
    }

}