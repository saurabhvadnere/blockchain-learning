// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AdvancedGuestbook {
    address public owner;

    struct Entry {
        string text;
        uint256 timestamp;
    }

    mapping(address => Entry) public guestbook;

    // A modifier helps keep code "DRY" (Don't Repeat Yourself)
    modifier onlyOwner() {
        require(msg.sender == owner, "Not the owner");
        _; // This underscore tells Solidity to run the rest of the function here
    }

    constructor() {
        owner = msg.sender;
    }

    function sign(string memory _text) public {
        guestbook[msg.sender] = Entry({
            text: _text,
            timestamp: block.timestamp // Records the current time
        });
    }

    // Now we just add the modifier name to the function header
    function clearEntry(address _user) public onlyOwner {
        delete guestbook[_user];
    }
}