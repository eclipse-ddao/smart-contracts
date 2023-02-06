// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

import "./eclipse-dao.sol";

contract EclipseDataDaoFactory {

  event ContractCreated(address newAddress);

  mapping(string => address) _eclipses;

  function createEclipseDataDao(string memory id) public {
    EclipseDataDao eclipse = new EclipseDataDao(msg.sender); 
    _eclipses[id] = address(eclipse);
    emit ContractCreated(address(eclipse));
  }

  function getEclipse(string memory id)
        public
        view 
        returns (address)
    {
        return _eclipses[id];
    }

}
