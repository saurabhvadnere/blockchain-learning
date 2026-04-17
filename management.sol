// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentManager {

    // 1. STRUCT
    struct Student {
        string name;
        uint age;
    }

    // 2. MAPPING (address => Student)
    mapping(address => Student) public students;

    // 3. ARRAY (to store student addresses)
    address[] public studentList;

    address public owner;

    // 4. CONSTRUCTOR (runs once at deployment)
    constructor() {
        owner = msg.sender;
    }

    // 5. MODIFIER (only owner can call certain functions)
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _;
    }

    // Function to add a student
    function addStudent(address _addr, string memory _name, uint _age) public onlyOwner {
        students[_addr] = Student(_name, _age);
        studentList.push(_addr);
    }

    // Function to get student details
    function getStudent(address _addr) public view returns (string memory, uint) {
        Student memory s = students[_addr];
        return (s.name, s.age);
    }

    // Function to get total students
    function getTotalStudents() public view returns (uint) {
        return studentList.length;
    }

    function getAllStudents() public view returns (Student[] memory) {
    
    Student[] memory allStudents = new Student[](studentList.length);

    for (uint i = 0; i < studentList.length; i++) {
        address addr = studentList[i];
        allStudents[i] = students[addr];
    }

    return allStudents;
}
}