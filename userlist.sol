// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UserArray{
    string[] public names;
    string[] public emails;

    function addUser(string memory _name, string memory _email) public {
        names.push(_name);
        emails.push(_email);
    }
    function getUser(uint _index) public view returns (string memory, string memory){
        return (names[_index],emails[_index]);
    }
}