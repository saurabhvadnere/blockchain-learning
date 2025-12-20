// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

contract Student_management{
    
    struct Student{
        uint stud_id;
        string Name;
        string department;
    }

    Student [] Students;

    function add_stud(uint _stud_id, string memory _Name, string memory _department) public {
        Student memory stud = Student(_stud_id,_Name,_department);
        Students.push(stud);
    }

    function getStudent_details(uint stud_id) public view returns (string memory, string memory){
        for(uint i = 0; i<Students.length; i++){
            Student memory stud = Students[i];

            if (stud.stud_id == stud_id){
                return (stud.Name, stud.department);
            }
        }
        return ("Not Found","Not Found");
    }
}
