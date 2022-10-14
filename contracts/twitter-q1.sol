// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

contract Twitter {
	// ----- START OF DO-NOT-EDIT ----- //
	struct Tweet {
		uint256 tweetId;
		address author;
		string content;
		uint256 createdAt;
	}

	struct User {
		address wallet;
		string name;
		uint256[] userTweets;
	}

	mapping(address => User) public users;
	mapping(uint256 => Tweet) public tweets;
	uint256 public nextTweetId;

	// ----- END OF DO-NOT-EDIT ----- //

	function registerAccount(string calldata _name) external {
		bytes memory bname = bytes(_name);
		require(bname.length != 0, 'Name cannot be an empty string');
		User storage newUser = users[msg.sender];
		newUser.name = _name;
		newUser.wallet = msg.sender;
	}

	function postTweet(string calldata _content) external accountExists(msg.sender) {
		Tweet storage newTweet = tweets[nextTweetId];
		newTweet.createdAt = block.timestamp;
		newTweet.author = msg.sender;
		newTweet.content = _content;
		newTweet.tweetId = nextTweetId;
		users[msg.sender].userTweets.push(nextTweetId);
		nextTweetId += 1;
	}

	function readTweets(address _user) external view returns (Tweet[] memory) {
		uint256[] memory userTweetIds = users[_user].userTweets;
		Tweet[] memory userTweets = new Tweet[](userTweetIds.length);
		for (uint256 i = 0; i < userTweetIds.length; i += 1) {
			userTweets[i] = tweets[userTweetIds[i]];
		}
		return userTweets;
	}

	modifier accountExists(address _user) {
		User memory thisUser = users[_user];
		bytes memory thisUserBname = bytes(thisUser.name);
		require(thisUserBname.length != 0, 'This wallet does not belong to any account.');
		_;
	}
}
