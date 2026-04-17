// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract LinkedIn{

    uint public MaxLength = 280; // LinkedIn-style longer post limit
    struct LinkedInPost {
        uint id;
        address author;
        string content;
        uint timestamp;
        uint likes;
    }

    mapping(address => LinkedInPost[]) public posts;

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only owner can change length");
        _;
    }

    function changePostLength(uint _newLength) public onlyOwner {
        MaxLength = _newLength;
    }

    function createPost(string memory _msg) public {
        require(bytes(_msg).length <= MaxLength, "Max characters reached");
        LinkedInPost memory newPost = LinkedInPost({
            id: posts[msg.sender].length,
            author: msg.sender,
            content: _msg,
            timestamp: block.timestamp,
            likes: 0
        });
        posts[msg.sender].push(newPost);
    }

    function likePost(address _author, uint _index) external {
        require(_index < posts[_author].length, "Post does not exist");
        require(posts[_author][_index].id == _index, "Post id mismatch");
        posts[_author][_index].likes++;
    }

    function unlikePost(address _author, uint _index) external {
        require(_index < posts[_author].length, "Post does not exist");
        require(posts[_author][_index].id == _index, "Post id mismatch");
        require(posts[_author][_index].likes > 0, "No likes to remove");
        posts[_author][_index].likes--;
    }

    function getOnePost(address _author, uint _index) public view returns (LinkedInPost memory) {
        require(_index < posts[_author].length, "Post does not exist");
        return posts[_author][_index];
    }

    function getAllPosts(address _author) public view returns (LinkedInPost[] memory) {
        return posts[_author];
    }
}
