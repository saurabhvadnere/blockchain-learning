// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract TaskManager {

    struct Task {
        string title;
        bool completed;
    }

    mapping(address => Task[]) public userTasks;
    address[] public users;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyNewUser() {
        bool exists = false;

        for (uint i = 0; i < users.length; i++) {
            if (users[i] == msg.sender) {
                exists = true;
                break;
            }
        }

        if (!exists) {
            users.push(msg.sender);
        }

        _;
    }

    // Add Task
    function addTask(string memory _title) public onlyNewUser {
        userTasks[msg.sender].push(Task(_title, false));
    }

    // Mark Task as Completed
    function completeTask(uint index) public {
        require(index < userTasks[msg.sender].length, "Invalid index");
        userTasks[msg.sender][index].completed = true;
    }

    // Get My Tasks
    function getMyTasks() public view returns (Task[] memory) {
        return userTasks[msg.sender];
    }

    // Get All Users Tasks 
    function getAllTasks(address _user) public view returns (Task[] memory) {
        return userTasks[_user];
    }
}
