// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AttendanceSystem {

    // 👤 Owner (Teacher)
    address public owner;

    // 📅 attendance[student][day] => true / false
    mapping(address => mapping(uint => bool)) private attendance;

    // 🔔 Event when attendance is marked
    event AttendanceMarked(
        address indexed student,
        uint indexed day,
        bool status
    );

    // 🔐 Modifier: Only owner (teacher) can mark attendance
    modifier onlyOwner() {
        require(msg.sender == owner, "Only teacher can mark attendance");
        _;
    }

    // 🏗 Constructor sets the deployer as teacher
    constructor() {
        owner = msg.sender;
    }

    // 📝 Mark attendance for a student on a specific day
    function markAttendance(address _student, uint _day) public onlyOwner {

        require(_student != address(0), "Invalid student address");

        // Optional: prevent double marking
        require(attendance[_student][_day] == false, "Attendance already marked");
        attendance[_student][_day] = true;

        emit AttendanceMarked(_student, _day, true);
    }

    // 👀 Student checks their attendance for a day
    function checkMyAttendance(uint _day) public view returns (bool) {
        return attendance[msg.sender][_day];
    }

    // 👨‍🏫 Teacher checks attendance of any student
    function checkStudentAttendance(address _student,uint _day) public view onlyOwner returns (bool) {
        return attendance[_student][_day];
    }
}
