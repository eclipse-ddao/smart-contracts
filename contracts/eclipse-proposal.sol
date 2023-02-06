// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./BigFile.sol";
import "./eclipse-dao.sol";
import "./lib/openzeppelin-contracts/contracts/utils/math/SafeMath.sol";
import "./lib/filecoin-solidity/contracts/v0.8/types/MarketTypes.sol";
import "./lib/filecoin-solidity/contracts/v0.8/MarketAPI.sol";

contract EclipseBigFileProposal {

  using SafeMath for uint256;

  uint dealAmount;
  address selectedStorageProvider;
  address payable daoAddress;
  uint dealDurationInDays;
  uint storageSize;
  uint dealStartBlockStamp;

  modifier storageProviderOnly() {
    _;
    require(msg.sender == selectedStorageProvider);
  } 

  modifier daoMemberOnly() {
    _;
    EclipseDataDao dataDao = EclipseDataDao(daoAddress);
    require(dataDao.isMember(msg.sender));
  }


  constructor(
    uint _dealAmount,
    address _selectedStorageProvider,
    address payable _daoAddress,
    uint _storageSize,
    uint _dealDurationInDays 
  ) {
    dealAmount = _dealAmount;
    selectedStorageProvider = _selectedStorageProvider;
    daoAddress = _daoAddress;
    dealStartBlockStamp = block.timestamp;
    dealDurationInDays = _dealDurationInDays;
    storageSize = _storageSize;
  }

  function verifyDealActive(uint64 dealId) daoMemberOnly() public {
    // Verify that the size is valid and as expected 
        MarketTypes.GetDealDataCommitmentReturn memory commitmentRet = MarketAPI.getDealDataCommitment(MarketTypes.GetDealDataCommitmentParams({id: dealId}));
        MarketTypes.GetDealProviderReturn memory providerRet = MarketAPI.getDealProvider(MarketTypes.GetDealProviderParams({id: dealId}));

        require(commitmentRet.size == storageSize);
    // Verify that the client is valid
         MarketTypes.GetDealClientReturn memory clientRet = MarketAPI.getDealClient(MarketTypes.GetDealClientParams({id: dealId}));
  }

  function requestPayout() storageProviderOnly() public {
    // Check if the expiry has passed and in that case, payout to the storage provider
    if ((block.timestamp.sub(dealStartBlockStamp)).div(1 days) >= dealDurationInDays) {

    }
  }

  fallback() external payable {}
  receive() external payable {}

}

