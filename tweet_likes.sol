// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
// tweet using event call tweet_create, use parameter id, author , content , timestamp
// emit the tweet using event
// create another event like_tweet use parameter liker, tweet_author, tweet_id , new_like_count
contract Tweet{

    uint public Max_length = 280;
    struct MyTweet{
        uint id;
        address author;
        string content;
        uint timestamp;
        uint likes;
    }

    mapping(address=>MyTweet[]) public tweets;
    address public author_Owner;
    
    // create all event
    event tweet_create (uint id, address author, string content, uint timestamp);
    event like_tweet (address liker, address tweet_author, uint tweet_id, uint new_like_count);
    event unlike_tweet (address unliker, address tweet_author, uint tweet_id, uint new_like_count);

    constructor (){
        author_Owner = msg.sender;
    }

    modifier Only_Owner(){
        require(msg.sender == author_Owner,"Only owner can be change length");
        _;
    }

    function changeTweet_length (uint _enter_new_Length) public Only_Owner {
        Max_length = _enter_new_Length;
    }

    function Create_Tweet(string memory _msg) public{
        require(bytes(_msg).length <= Max_length, "Max Characters Reached");
    MyTweet memory newTweet=MyTweet({
        id:tweets[msg.sender].length,
        author:msg.sender,
        content:_msg,
        timestamp:block.timestamp,
        likes:0
        });
    tweets[msg.sender].push(newTweet);
    // emit or throw a event 
    emit tweet_create(newTweet.id, newTweet.author, newTweet.content, newTweet.timestamp);
    }

    function likeTweet (address Owner, uint x) external  {
        require(tweets[Owner][x].id == x,"Tweet does not exist");
        tweets[Owner][x].likes++;
    // emit or throw a event 
    // like_tweet use parameter liker, tweet_author, tweet_id , new_like_count
    emit like_tweet(msg.sender, Owner, x, tweets[Owner][x].likes);
    }

    function unlikeTweet (address Owner, uint x) external  {
        require(tweets[Owner][x].id == x,"Tweet does not exist");
        require(tweets[Owner][x].likes>0,"Tweet has no like");

        tweets[Owner][x].likes--;

        emit unlike_tweet(msg.sender, Owner, x, tweets[Owner][x].likes);
    }

    function get_One_Tweet(address _owner,uint i) public view returns (MyTweet memory){
        return tweets[_owner][i];
    }

    function get_All_Tweet(address _owner) public view returns (MyTweet[] memory){
        return tweets[_owner];
    }

}