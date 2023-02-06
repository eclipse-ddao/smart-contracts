task("is-dao-member", "Check if a given address is a dao member or not").setAction(
    async (taskArgs) => {
        const networkId = network.name
        console.log("Running task on ", networkId)
        // const contractAddr = "0x85CaA24F2e3C28e5eCB429B770e247fa180DeAD8" // matic
        const contractAddr = "0x32a698913ba2045Acb9285a41b2fbf6c6968DdE8" // hyperspace
        const wallet = new ethers.Wallet(network.config.accounts[0], ethers.provider)
        const EDDao = await ethers.getContractFactory("EclipseDataDaoFactory", wallet)
        const eddao = await EDDao.attach(contractAddr)
        const memberAddr = "0xbcddf97965525Db40635B205aDDf93F990F4f1fc"
        const tx1 = await eddao.createEclipseDataDao("rand2")
        console.log({ tx1 })
        console.log({ tx1: await tx1.wait() })
        const deployedAddr = await eddao.getEclipse("rand2")
        console.log({ deployedAddr })
        // const tx2 = await eddao.isMember(memberAddr)
        // console.log({ tx2 })
    }
)
