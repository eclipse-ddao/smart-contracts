// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./BigFile.sol";
import "./eclipse-proposal.sol";

contract EclipseDataDao{
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


	modifier memberOnly() {
		_;
		require(members[msg.sender] == true);
	}

	constructor(address member) {
		members[member] = true;
	}


	// --------- Membership related methods
	mapping(address => bool) members;

	function addMember(address newMember) public memberOnly() {
		members[newMember] = true;
	}

	function isMember(address member) external view returns(bool) {
		return members[member];
	}

	// --------- Big File related methods

	mapping(uint => address) public _selectedProposals;
	mapping(uint => BigFile) public _bigFiles;
	mapping(uint => bool) public _bigFilesIds;

	function addBigFile(BigFile calldata data) public memberOnly() {
		require(!_bigFilesIds[data.id], "Invalid Big File ID");
		_bigFiles[data.id] = data;
		_bigFilesIds[data.id] = true;
	}

	// Create a new smart contract to lock funds and create the deal
	// This can only be done by the selected proposer
	function acceptProposal(uint bigFileId, address acceptedSp, uint dealAmount) external memberOnly() {
		// Check if the Big File Id is valid
		require(_bigFilesIds[bigFileId], "Invalid Big File ID");
		BigFile memory bigFile = _bigFiles[bigFileId];
		_bigFiles[bigFileId].spAddress = acceptedSp;
		_bigFiles[bigFileId].bounty = dealAmount;
		require(dealAmount <= address(this).balance);
		EclipseBigFileProposal proposal = new EclipseBigFileProposal(dealAmount, acceptedSp, payable(address(this)), bigFile.sizeInGb, bigFile.duration);
		_selectedProposals[bigFileId] = address(proposal);

		// Lock up funds
		// payable(address(proposal)).transfer(dealAmount);
	}

	function getBigFile(uint id) external view returns(BigFile memory) {
		return _bigFiles[id];
	}

	function getSelectedProposal(uint id) external view returns(address) {
		return _selectedProposals[id];
	}

	fallback() external payable {}
	receive() external payable {}
}

