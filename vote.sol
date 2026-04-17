// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract SimpleVoting {

    struct Proposal {
        string name;
        uint256 voteCount;
    }

    Proposal[] public proposals;

    // Track if user has voted
    mapping(address => bool) public hasVoted;

    // 🔹 Add Proposal
    function addProposal(string memory _name) public {
        proposals.push(Proposal(_name, 0));
    }

    // 🔹 Vote (1 person = 1 vote)
    function vote(uint256 _proposalId) public {
        require(!hasVoted[msg.sender], "Already voted");

        proposals[_proposalId].voteCount += 1;
        hasVoted[msg.sender] = true;
    }

    // 🔹 Get Winner
    function getWinner() public view returns (string memory winnerName) {
        uint256 maxVotes = 0;
        uint256 winnerIndex = 0;

        for (uint256 i = 0; i < proposals.length; i++) {
            if (proposals[i].voteCount > maxVotes) {
                maxVotes = proposals[i].voteCount;
                winnerIndex = i;
            }
        }

        return proposals[winnerIndex].name;
    }
}