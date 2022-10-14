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

    struct Message {
        uint messageId;
        string content;
        address from;
        address to;
    }

    struct User {
        address wallet;
        string name;
        uint[] userTweets;
        address[] following;
        address[] followers;
        mapping(address => Message[]) conversations;
    }

    mapping(address => User) public users;
    mapping(uint => Tweet) public tweets;

    uint256 public nextTweetId;
    uint256 public nextMessageId;
    // ----- END OF DO-NOT-EDIT ----- //

    // ----- START OF QUEST 1 ----- //
    function registerAccount(string calldata _name) external {

    }

    function postTweet(string calldata _content) external accountExists(msg.sender) {     

    }

    function readTweets(address _user) view external returns(Tweet[] memory) {

    }

    modifier accountExists(address _user) {
        _;
    }
    // ----- END OF QUEST 1 ----- //

    // ----- START OF QUEST 2 ----- //
    function followUser(address _user) external {

    }

    function getFollowing() external view returns(address[] memory)  {

    }

    function getFollowers() external view returns(address[] memory) {

    }

    function getTweetFeed() view external returns(Tweet[] memory) {

    }

    function sendMessage(address _recipient, string calldata _content) external {

    }

    function getConversationWithUser(address _user) external view returns(Message[] memory) {

    }
    // ----- END OF QUEST 2 ----- //
}