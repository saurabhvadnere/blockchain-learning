// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// Custom Errors (Modern Gas-Saving approach)
error WithdrawalTooEarly(uint256 availableAt);
error InsufficientBalance();
error ReentrancyAttempt();
error TransferFailed();

contract LockedVault {
    struct Vault {
        uint256 balance;
        uint256 unlockTime;
    }

    mapping(address => Vault) public vaults;
    bool private locked; 

    event Deposited(address indexed user, uint256 amount, uint256 unlockTime);
    event Withdrawn(address indexed user, uint256 amount);

    // Simple Reentrancy Guard
    modifier nonReentrant() {
        if (locked) revert ReentrancyAttempt();
        locked = true;
        _;
        locked = false;
    }

    /**
     * @notice Deposit ETH and extend lock duration
     * @param _duration Time in seconds from now until funds are available
     */
    function deposit(uint256 _duration) external payable {
        if (msg.value == 0) revert InsufficientBalance();

        Vault storage userVault = vaults[msg.sender];
        
        userVault.balance += msg.value;
        // Extend/Set the unlock time to current time + duration
        userVault.unlockTime = block.timestamp + _duration;

        emit Deposited(msg.sender, msg.value, userVault.unlockTime);
    }

    /**
     * @notice Withdraw full balance after lock expires
     */
    function withdraw() external nonReentrant {
        Vault storage userVault = vaults[msg.sender];

        // 1. CHECKS
        if (userVault.balance == 0) revert InsufficientBalance();
        if (block.timestamp < userVault.unlockTime) {
            revert WithdrawalTooEarly(userVault.unlockTime);
        }

        // 2. EFFECTS (Change state BEFORE sending money)
        uint256 amountToTransfer = userVault.balance;
        userVault.balance = 0;
        userVault.unlockTime = 0;

        // 3. INTERACTIONS
        (bool success, ) = msg.sender.call{value: amountToTransfer}("");
        if (!success) revert TransferFailed();

        emit Withdrawn(msg.sender, amountToTransfer);
    }
}
