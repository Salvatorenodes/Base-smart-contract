import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox';
import "@nomiclabs/hardhat-etherscan";

require('dotenv').config();

const config: HardhatUserConfig = {
  solidity: {
    version: '0.8.17',
  },
  networks: {
    // for testnet
    'base-goerli': {
      url: 'https://goerli.base.org',
      accounts: [process.env.WALLET_KEY as string],
    },
    // for local dev environment
    'base-local': {
      url: 'http://localhost:8545',
      accounts: [process.env.WALLET_KEY as string],
    },
  },
  defaultNetwork: 'hardhat',
  
  etherscan: {
    apiKey: {
      // Uncomment for Blockscout
      // No api key is needed for Basescan

      // Blockscout
       "base-goerli": "your_API_from_Base"
    },
    customChains: [
      {
        network: "base-goerli",
        chainId: 84531,
        urls: {
          // Pick a block explorer and uncomment those lines

          // Blockscout
          // apiURL: "https://base-goerli.blockscout.com/api",
          // browserURL: "https://base-goerli.blockscout.com"

          // Basescan by Etherscan
          apiURL: "https://api-goerli.basescan.org/api",
          browserURL: "https://goerli.basescan.org"
        }
      }
    ]
  }
};

export default config;
