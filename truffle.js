
const HDWalletProvider = require("truffle-hdwallet-provider-privkey");
const privateKeys = [""]; // private keys

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
        return new HDWalletProvider(privateKeys, "https://ropsten.infura.io/v3/");
      },
      gasPrice: 10000000000,
      network_id: 3
    },
    coverage: {
      host: 'localhost',
      network_id: '*',      // eslint-disable-line camelcase
      port: 8555,           // <-- If you change this, also set the port option in .solcover.js.
      gas: 0xfffffffffff,   // <-- Use this high gas value
      gasPrice: 0x01        // <-- Use this low gas price
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
  }
};