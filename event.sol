// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Event_Example{

    event new_user_register(address indexed user, string user_name, uint age);

    struct User {
    string name;
    uint age;
    }

    mapping (address=>User) public users;

    function register_user(string memory _username, uint _age) public {
        User storage New_user = users[msg.sender];
        New_user.name = _username;
        New_user.age = _age;

        emit new_user_register (msg.sender,_username,_age);
    }
}
