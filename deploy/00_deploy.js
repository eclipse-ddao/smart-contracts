const { ethers } = require("hardhat")
const { networkConfig } = require("../helper-hardhat-config")

const private_key = network.config.accounts[0]
const wallet = new ethers.Wallet(private_key, ethers.provider)

module.exports = async ({ deployments }) => {
    console.log("Wallet Ethereum Address:", wallet.address)
    const chainId = network.config.chainId

    const EclipseDataDaoFactory = await ethers.getContractFactory("EclipseDataDaoFactory", wallet)
    const eDDaoFactory = await EclipseDataDaoFactory.deploy()
    await eDDaoFactory.deployed()
    console.log("Eclipse Data Dao Factory deployed to:", eDDaoFactory.address)

    //deploy Simplecoin
    // const EclipseDAO = await ethers.getContractFactory("EclipseDDAO", wallet)
    // console.log("Deploying Eclipse Data Dao...")
    // const eDDao = await EclipseDAO.deploy()
    // await eDDao.deployed()
    // console.log("Eclipse Data Dao deployed to:", eDDao.address)

    // //deploy FilecoinMarketConsumer
    // const FilecoinMarketConsumer = await ethers.getContractFactory('FilecoinMarketConsumer', wallet);
    // console.log('Deploying FilecoinMarketConsumer...');
    // const filecoinMarketConsumer = await FilecoinMarketConsumer.deploy();
    // await filecoinMarketConsumer.deployed()
    // console.log('FilecoinMarketConsumer deployed to:', filecoinMarketConsumer.address);
    //
    // //deploy DealRewarder
    // const DealRewarder = await ethers.getContractFactory('DealRewarder', wallet);
    // console.log('Deploying DealRewarder...');
    // const dealRewarder = await DealRewarder.deploy();
    // await dealRewarder.deployed()
    // console.log('DealRewarder deployed to:', dealRewarder.address);
}
