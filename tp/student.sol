// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentMarksControl {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    struct Student {
        string name;
        uint marks;
    }

    mapping(address => Student) public students;

    modifier onlyOwner() {
        require(msg.sender == owner, "Not allowed");
        _;
    }

    // Only teacher can assign marks
    function setStudent(address _student, string memory _name, uint _marks) public onlyOwner {
        students[_student] = Student(_name, _marks);
    }

    function getStudent(address _student) public view returns (string memory, uint) {
        Student memory s = students[_student];
        return (s.name, s.marks);
    }
}