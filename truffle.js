
const HDWalletProvider = require("truffle-hdwallet-provider-privkey");
const privateKeys = ["PrivateKey"]; // private keys

module.exports = {
  //Network : 배포 할 네트워크에 대한 Config
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*" // Match any network id
    },
    ropsten: {
      provider: () => {
        return new HDWalletProvider(privateKeys, "https://ropsten.infura.io/v3/APIKEY")
      },
      gasPrice: 10000000000,
      network_id: 3
    }
  },
  //
  rpc: {
    host: "localhost",
    post:8545
  },
  //Solc : Solidity Compile 관련 옵션- 상세 내용은 추가바랍니다.
  solc: {
    optimizer: {
        enabled: true,
        runs: 200
    }
  },
  mocha: {
    reporter: 'eth-gas-reporter',
    reporterOptions : {
      gasPrice: 21
    }
  }
};