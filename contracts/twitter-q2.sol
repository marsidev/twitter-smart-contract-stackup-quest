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

	struct Message {
		uint256 messageId;
		string content;
		address from;
		address to;
	}

	struct User {
		address wallet;
		string name;
		uint256[] userTweets;
		address[] following;
		address[] followers;
		mapping(address => Message[]) conversations;
	}

	mapping(address => User) public users;
	mapping(uint256 => Tweet) public tweets;

	uint256 public nextTweetId;
	uint256 public nextMessageId;

	// ----- END OF DO-NOT-EDIT ----- //

	// ----- START OF QUEST 1 ----- //
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
		User storage thisUser = users[_user];
		bytes memory thisUserBname = bytes(thisUser.name);
		require(thisUserBname.length != 0, 'This wallet does not belong to any account.');
		_;
	}

	// ----- END OF QUEST 1 ----- //

	// ----- START OF QUEST 2 ----- //
	function followUser(address _user) external {
		User storage followerUser = users[msg.sender];
		followerUser.following.push(_user);

		User storage followingUser = users[_user];
		followingUser.followers.push(msg.sender);
	}

	function getFollowing() external view returns (address[] memory) {
		return users[msg.sender].following;
	}

	function getFollowers() external view returns (address[] memory) {
		return users[msg.sender].followers;
	}

	function getTweetFeed() external view returns (Tweet[] memory) {
		Tweet[] memory feedTweets = new Tweet[](nextTweetId);

		for (uint256 i = 0; i < nextTweetId; i += 1) {
			feedTweets[i] = tweets[i];
		}

		return feedTweets;
	}

	function sendMessage(address _recipient, string calldata _content) external {
		// getting users
		User storage senderUser = users[msg.sender];
		User storage recipientUser = users[_recipient];

		// getting their conversations
		Message[] storage senderMessages = senderUser.conversations[_recipient];
		Message[] storage recipientMessages = recipientUser.conversations[msg.sender];

		// creating the message struct
		Message memory newMessage;
		newMessage.content = _content;
		newMessage.from = msg.sender;
		newMessage.to = _recipient;
		newMessage.messageId = nextMessageId;

		// pushing messages
		senderMessages.push(newMessage);
		recipientMessages.push(newMessage);

		// incrementing next message id
		nextMessageId += 1;
	}

	function getConversationWithUser(address _user) external view returns (Message[] memory) {
		User storage thisUser = users[msg.sender];
		return thisUser.conversations[_user];
	}
	// ----- END OF QUEST 2 ----- //
}
