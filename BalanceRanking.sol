// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BalanceRanking {
    address public owner;
    address[] public owners;
    mapping(address => uint256) public balances;
    mapping(address => bool) private isOwner;

    // 🔔 EVENTS
    event ValueAdded(address indexed user, uint256 amount);
    event OwnerAdded(address indexed user);
    event LowestBalanceRewarded(address indexed winner, uint256 rewardAmount);

    // 🔹 Constructor
    constructor() {
        owner = msg.sender;
    }

    // 🔹 Modifier
    modifier onlyOwner() {
        require(msg.sender == owner, "Not contract owner");
        _;
    }

    // 🔹 Add ETH value
    function addValue() external payable {
        require(msg.value > 0, "Send some ETH");
        // new owner
        if (!isOwner[msg.sender]) {
            owners.push(msg.sender);
            isOwner[msg.sender] = true;
            emit OwnerAdded(msg.sender);
        }
        balances[msg.sender] += msg.value;
        emit ValueAdded(msg.sender, msg.value);
    }

    // 🔹 Get owners sorted by highest balance (OWNER ONLY)
    function getSortedOwners() external view onlyOwner returns (address[] memory) {
        address[] memory sortedOwners = owners;
        for (uint256 i = 0;
        i < sortedOwners.length;
        i++) {
            for (uint256 j = i + 1;
            j < sortedOwners.length;
            j++) {
                if (balances[sortedOwners[j]] > balances[sortedOwners[i]]) {
                    (sortedOwners[i], sortedOwners[j]) =
                    (sortedOwners[j], sortedOwners[i]);
                }
            }
        }
        return sortedOwners;
    }

    // 🔥 Lowest balance address gets ALL contract ETH
    function rewardLowestBalanceOwner() external onlyOwner {
        require(owners.length > 0, "No owners");
        require(address(this).balance > 0, "No ETH in contract");
        address lowestOwner = owners[0];
        uint256 lowestBalance = balances[lowestOwner];
        for (uint256 i = 1;
        i < owners.length;
        i++) {
            if (balances[owners[i]] < lowestBalance) {
                lowestBalance = balances[owners[i]];
                lowestOwner = owners[i];
            }
        }
        uint256 contractBalance = address(this).balance;
        (bool success, ) = payable(lowestOwner).call {
            value: contractBalance
        }
        ("");
        require(success, "Transfer failed");
        emit LowestBalanceRewarded(lowestOwner, contractBalance);
    }

    // 🔹 Total owners
    function totalOwners() external view returns (uint256) {
        return owners.length;
    }
}
