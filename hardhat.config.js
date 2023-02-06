require("@nomicfoundation/hardhat-toolbox")
require("hardhat-deploy")
require("hardhat-deploy-ethers")
require("./tasks")
require("dotenv").config()

const PRIVATE_KEY = process.env.PRIVATE_KEY
const MATIC_PRIVATE_KEY = process.env.MATIC_PRIVATE_KEY
/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
    solidity: "0.8.17",
    defaultNetwork: "hyperspace",
    networks: {
        local: {
            url: "http://127.0.0.1:8545/",
            accounts: ["0x2a26ca0651ec99d87f275e568794160309ef5b2926283ffeb66a635e48b4da14"],
        },
        hyperspace: {
            chainId: 3141,
            url: "https://api.hyperspace.node.glif.io/rpc/v1",
            accounts: [PRIVATE_KEY],
        },
        matic: {
            url: "https://matic-mumbai.chainstacklabs.com",
            chainId: 80001,
            accounts: [MATIC_PRIVATE_KEY],
        },
    },
    paths: {
        sources: "./contracts",
        tests: "./test",
        cache: "./cache",
        artifacts: "./artifacts",
    },
}
