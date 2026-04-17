// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Twitter {

    uint16 public MAX_TWEET_LENGTH = 280;

    struct Tweet {
        uint id;
        address author;
        string content;
        uint256 timestamp;
        uint256 likes;
    }

    Tweet[] public allTweets;

    function createTweet(string memory _tweet) public {
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

    function likeTweet(uint _id) public {
        require(_id < allTweets.length, "Tweet not found");
        allTweets[_id].likes++;
    }

    function dislikeTweet(uint _id) public {
        require(_id < allTweets.length, "Tweet not found");
        require(allTweets[_id].likes > 0, "No likes to remove");
        allTweets[_id].likes--;
    }

    function getAllTweets() public view returns (Tweet[] memory) {
        return allTweets;
    }
}