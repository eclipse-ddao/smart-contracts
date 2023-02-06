task("add-big-file", "add a big file to a Data Dao").setAction(async (taskArgs) => {
    const networkId = network.name
    console.log("Running task on ", networkId)
    const wallet = new ethers.Wallet(network.config.accounts[0], ethers.provider)
    const dataDaoAddr = "0x37c6DaD9FDB047C1b75774ce00caFAC9756a8758"
    // const dataDaoAddr = "0xC850dDBb6F51b942E810d9A495415f15CB083f62"
    const DataDao = await ethers.getContractFactory("EclipseDataDao", wallet)
    const dataDao = await DataDao.attach(dataDaoAddr)
    const walletAddr = wallet.address

    // const Proposal = await ethers.getContractFactory("EclipseBigFileProposal", wallet)
    // await Proposal.deploy()
    const tx = await dataDao.addBigFile(
        {
            id: 2,
            proposer: walletAddr,
            bounty: 1,
            sizeInGb: 1,
            duration: 1,
            startedAt: 0,
            spAddress: walletAddr,
            status: 1,
        },
        {
            gasLimit: 10000000,
        }
    )
    console.log(await tx.wait())
    console.log("________________ ONE DONE ______________-")

    const tx2 = await dataDao.acceptProposal(2, walletAddr, 100, {
        gasLimit: 10000000,
    })

    console.log(await tx2.wait())

    // console.log(await dataDao.getBigFile(2))
})
