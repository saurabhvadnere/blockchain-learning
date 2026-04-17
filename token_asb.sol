// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

// ERC-20 Token Contract by ASB
contract ASBToken {
    // Mapping to store token balances
    mapping(address => uint256) balances;

    // Mapping to store allowances
    mapping(address => mapping(address => uint256)) allowed;

    // Total supply of tokens
    uint256 private _totalSupply = 500;

    // Owner of the contract
    address public owner;

    // Approval event
    event Approval(
        address indexed tokenOwner,
        address indexed spender,
        uint256 tokens
    );
    // Transfer event
    event Transfer(address indexed from, address indexed to, uint256 tokens);
    // Constructor to assign total supply to owner
    constructor() {
        owner = msg.sender;
        balances[owner] = _totalSupply;
    }

    // Returns total token supply
    function totalSupply() public view returns (uint256) {
        return _totalSupply;
    }
    // Returns token balance of a given address
    function balanceOf(address tokenOwner) public view returns (uint256) {
        return balances[tokenOwner];
    }
    // Approves a spender to withdraw tokens
    function approve(address spender, uint256 tokens) public returns (bool) {
        allowed[msg.sender][spender] = tokens;
        emit Approval(msg.sender, spender, tokens);
        return true;
    }
    // Transfers tokens from sender to receiver
    function transfer(address to, uint256 tokens) public returns (bool) {
        require(balances[msg.sender] >= tokens, "Insufficient balance");
        balances[msg.sender] -= tokens;
        balances[to] += tokens;
        emit Transfer(msg.sender, to, tokens);
        return true;
    }
    // Transfers tokens on behalf of another address
    function transferFrom(
        address from,
        address to,
        uint256 tokens
    ) public returns (bool) {
        require(balances[from] >= tokens, "Insufficient balance");
        require(allowed[from][msg.sender] >= tokens, "Allowance exceeded");
        balances[from] -= tokens;
        balances[to] += tokens;
        allowed[from][msg.sender] -= tokens;
        emit Transfer(from, to, tokens);
        return true;
    }
    // Returns remaining allowance
    function allowance(
        address tokenOwner,
        address spender
    ) public view returns (uint256) {
        return allowed[tokenOwner][spender];
    }
}
