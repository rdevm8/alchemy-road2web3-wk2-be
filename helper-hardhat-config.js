const { ethers } = require("hardhat")

const networkConfig = {
    4: {
        name: "rinkeby",
        minTip: ethers.utils.parseEther("0.01"),
        tippers: 5,
    },
    5: {
        name: "goerli",
        minTip: ethers.utils.parseEther("0.01"),
        tippers: 5,
    },
    31337: {
        name: "hardhat",
        minTip: ethers.utils.parseEther("0.01"),
        tippers: 5,
    },
}

const contractConfig = {
    name: "BuyMeACoffee",
    frontend: {
        addressesFileLoc: "../wk2-fe/buymeacoffee-app/constants/contractAddress.json",
        abiFileLoc: "../wk2-fe/buymeacoffee-app/constants/abi.json",
    },
}

const mockMemo = {
    name: "rdevm8",
    message: "Here's a tip for you!",
}

const developmentChains = ["hardhat", "localhost"]

module.exports = {
    networkConfig,
    developmentChains,
    contractConfig,
    mockMemo,
}
