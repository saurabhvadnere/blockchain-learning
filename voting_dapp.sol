// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract VotingSystem {

    struct Candidate {
        uint id;
        string name;
        uint voteCount;
    }

    mapping(uint => Candidate) public candidates;
    mapping(address => bool) public hasVoted;

    address[] public voters;
    uint public candidatesCount;
    address public owner;

    constructor(string[] memory _names) {
        owner = msg.sender;

        for (uint i = 0; i < _names.length; i++) {
            candidatesCount++;
            candidates[candidatesCount] = Candidate(
                candidatesCount,
                _names[i],
                0
            );
        }
    }

    function vote(uint _candidateId) public {
        require(!hasVoted[msg.sender], "Already voted");
        require(_candidateId > 0 && _candidateId <= candidatesCount, "Invalid candidate");

        hasVoted[msg.sender] = true;
        voters.push(msg.sender);

        candidates[_candidateId].voteCount++;
    }

    function getWinner() public view returns (string memory winnerName, uint winnerVotes) {
        uint highest = 0;
        uint winnerId = 0;

        for (uint i = 1; i <= candidatesCount; i++) {
            if (candidates[i].voteCount > highest) {
                highest = candidates[i].voteCount;
                winnerId = i;
            }
        }

        winnerName = candidates[winnerId].name;
        winnerVotes = highest;
    }

    function getVoters() public view returns (address[] memory) {
        return voters;
    }
}
