// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

library SharedTypes {
	struct BigFile{
		uint256 id;
		address proposer;
		uint bounty;
		uint sizeInGb;
		uint duration;
		uint startedAt;
		address spAddress;
		uint status; // 1 - OPEN, 2 - SP Selected, 3 = Closed, 4 = Bounty Awarded
	}
}
