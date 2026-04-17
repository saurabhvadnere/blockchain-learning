// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract StudentData {

    struct Student {
        string name;
        uint age;
    }

    Student [] public s1;

    // function setStudent(string memory _name, uint _age) public {
    //     s1 = Student(_name, _age);   
    // }

    function setStudent(string memory names, uint age) public {
        s1.push(Student(names, age)); 
    }


function getstudent (uint index) public view returns (string memory, uint){
        require(index > 0 && index <= s1.length,"Invalid Index");

        Student memory s = s1[index - 1];
        return (s.name, s.age); 
    }

function getAll_student() public view returns (Student [] memory){
    return s1;
}

}