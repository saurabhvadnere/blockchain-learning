// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Room {

    uint16 public MAX_TWEET_LENGTH = 280;

    uint256 public startTime;
    uint256 public endTime;
    uint256 public constant DURATION = 30 minutes;

    struct Tweet {
        uint id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    Tweet[] public allTweets;

    // -------- CHECK IF ROOM ACTIVE --------
    function isRoomActive() public view returns (bool) {
        if (startTime == 0) {
            return false; // Not started yet
        }
        return block.timestamp <= endTime;
    }

    // -------- GET REMAINING TIME (for frontend countdown) --------
    function getRemainingTime() public view returns (uint256) {
        if (startTime == 0) {
            return 0; // Not started
        }

        if (block.timestamp >= endTime) {
            return 0; // Expired
        }

        return endTime - block.timestamp;
    }

    modifier onlyActive() {
        require(isRoomActive(), "Room is closed");
        _;
    }

    // -------- CREATE TWEET --------
    function createTweet(string memory _tweet) public {

        // Start timer on first tweet
        if (startTime == 0) {
            startTime = block.timestamp;
            endTime = block.timestamp + DURATION;
        }

        require(isRoomActive(), "Room is closed");
        require(bytes(_tweet).length <= MAX_TWEET_LENGTH, "Tweet too long!");

        allTweets.push(
            Tweet({
                id: allTweets.length,
                author: msg.sender,
                content: _tweet,
                timestamp: block.timestamp,
                likes: 0
            })
        );
    }

    // -------- LIKE --------
    function likeTweet(uint _id) public onlyActive {
        require(_id < allTweets.length, "Tweet not found");
        allTweets[_id].likes++;
    }

    // -------- DISLIKE --------
    function dislikeTweet(uint _id) public onlyActive {
        require(_id < allTweets.length, "Tweet not found");
        require(allTweets[_id].likes > 0, "No likes to remove");
        allTweets[_id].likes--;
    }

    // -------- VIEW ALL TWEETS --------
    function getAllTweets() public view returns (Tweet[] memory) {
        return allTweets;
    }
}