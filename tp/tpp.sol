// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract DemoContract {

    address public owner;
    uint256 public contractBalance;

    struct User {
        string name;
        uint256 age;
        address wallet;
        uint256 balance;
    }

    mapping(address => User) public users;
    address[] public userAddresses;

    event UserRegistered(address indexed user, string name, uint256 age);
    event EtherDeposited(address indexed from, uint256 amount);
    event EtherWithdrawn(address indexed to, uint256 amount);
    event UserUpdated(address indexed user, string name);

    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _;
    }

    modifier userExists(address _addr) {
        require(users[_addr].wallet != address(0), "User does not exist");
        _;
    }

    constructor() {
        owner = msg.sender;
    }

    function registerUser(string memory _name, uint256 _age) external {
        require(users[msg.sender].wallet == address(0), "User already exists");

        users[msg.sender] = User({
            name: _name,
            age: _age,
            wallet: msg.sender,
            balance: 0
        });

        userAddresses.push(msg.sender);
        emit UserRegistered(msg.sender, _name, _age);
    }

    function updateUserName(string memory _newName)
        external
        userExists(msg.sender)
    {
        users[msg.sender].name = _newName;
        emit UserUpdated(msg.sender, _newName);
    }

    function getAllUsers() external view returns (User[] memory) {
        User[] memory result = new User[](userAddresses.length);

        for (uint256 i = 0; i < userAddresses.length; i++) {
            result[i] = users[userAddresses[i]];
        }

        return result;
    }

    function deposit() external payable userExists(msg.sender) {
        users[msg.sender].balance += msg.value;
        contractBalance += msg.value;

        emit EtherDeposited(msg.sender, msg.value);
    }

    function withdraw(uint256 _amount)
        external
        userExists(msg.sender)
    {
        require(msg.sender == owner, "Not owner");
        require(
            users[msg.sender].balance >= _amount,
            "Insufficient user balance"
        );

        users[msg.sender].balance -= _amount;
        contractBalance -= _amount;

        payable(msg.sender).transfer(_amount);
        emit EtherWithdrawn(msg.sender, _amount);
    }

    receive() external payable {
        contractBalance += msg.value;
        emit EtherDeposited(msg.sender, msg.value);
    }

    fallback() external payable {
        contractBalance += msg.value;
    }

    error Unauthorized(address caller);

    function onlyOwnerFunction() external view {
        if (msg.sender != owner) {
            revert Unauthorized(msg.sender);
        }
    }
}
