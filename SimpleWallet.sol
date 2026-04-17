// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
contract SimpleWallet {
    // Store deposited Ether for each user
    mapping(address => uint) public balances;
    // Events
    event Deposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);
    event Received(address sender, uint amount);
    event FallbackCalled(address sender, uint amount, bytes data);

    // 1️Deposit Ether (payable function)
    function deposit() public payable {
        require(msg.value > 0, "Send some Ether");

        balances[msg.sender] += msg.value;

        emit Deposited(msg.sender, msg.value);
    }
    // 2️Withdraw using TRANSFER (auto reverts on failure)
    function withdrawUsingTransfer(uint amount) public {
        require(balances[msg.sender] >= amount, "Not enough balance");

        balances[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);

        emit Withdrawn(msg.sender, amount);
    }

// 3️ Withdraw using SEND (returns true/false)
    function withdrawUsingSend(uint amount) public {
        require(balances[msg.sender] >= amount, "Not enough balance");
        balances[msg.sender] -= amount;
        bool success = payable(msg.sender).send(amount);
        require(success, "Send failed");
        emit Withdrawn(msg.sender, amount);
    }
    // 4️ Withdraw using CALL (recommended way)
    function withdrawUsingCall(uint amount) public {
        require(balances[msg.sender] >= amount, "Not enough balance");
        balances[msg.sender] -= amount;
        (bool success, ) = payable(msg.sender).call{value: amount}("");
        require(success, "Call failed");
        emit Withdrawn(msg.sender, amount);
    }
    // 5️Check contract balance
    function getContractBalance() public view returns (uint) {
        return address(this).balance;
    }
    // 6️Receive Ether when msg.data is EMPTY
    receive() external payable {
        balances[msg.sender] += msg.value;
        emit Received(msg.sender, msg.value);
    }
    // 7️Fallback when msg.data is NOT EMPTY or function not found
    fallback() external payable {
        emit FallbackCalled(msg.sender, msg.value, msg.data);
    }
}
