// struct in solidity

// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract School {
    struct Student {
        uint id;
        string name;
        uint marks;
    }

    Student public s1; // a single object
    Student[] public students; // array of struct

    // set single student
    function setStudent() public {
        s1 = Student(1, "Rahul", 90);
    }

    // add student to array
    function addStudent(uint _id, string memory _name, uint _marks) public {
        students.push(Student(_id, _name, _marks));
    }
}
