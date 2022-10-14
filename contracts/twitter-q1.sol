// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Twitter {
    // ----- START OF DO-NOT-EDIT ----- //
    struct Tweet {
        uint tweetId;
        address author;
        string content;
        uint createdAt;
    }

    struct User {
        address wallet;
        string name;
        uint[] userTweets;
    }

    mapping(address => User) public users;
    mapping(uint => Tweet) public tweets;
    uint256 public nextTweetId;
    // ----- END OF DO-NOT-EDIT ----- //

    function registerAccount(string calldata _name) external {

    }

    function postTweet(string calldata _content) external accountExists(msg.sender) {     

    }

    function readTweets(address _user) view external returns(Tweet[] memory) {

    }

    modifier accountExists(address _user) {
        _;
    }

}