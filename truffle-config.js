const fs = require('fs')
const HDWalletProvider = require('@truffle/hdwallet-provider');
const pv_key = fs.readFileSync('./.secret').toString().trim();
const RPC_URL = "https://data-seed-prebsc-1-s1.binance.org:8545"
require('dotenv').config();

module.exports = {
  networks: {
    testnet: {
      network_id: 97,
      gas: 5500000,
      confirmations: 1,
      networkCheckTimeout: 20000,
      provider: () => new HDWalletProvider(pv_key, RPC_URL),
   },
  },

  // Set default mocha options here, use special reporters, etc.
  mocha: {
    // timeout: 100000
  },
  plugins: ["truffle-plugin-verify"],
  api_keys: {
    bscscan: process.env.API_KEY
  },
  // Configure your compilers
  compilers: {
    solc: {
      version: "0.8.17", // Fetch exact version from solc-bin (default: truffle's version)
      // docker: true,        // Use "0.5.1" you've installed locally with docker (default: false)
      settings: {          // See the solidity docs for advice about optimization and evmVersion
       optimizer: {
         enabled: false,
         runs: 200
       },
       evmVersion: "byzantium"
      }
    }
  }

};
