#!/usr/bin/env bash

echo "Updating and installing packages"
sudo apt update && sudo apt upgrade -y

sleep 1

echo "Installing expect"
sudo apt-get install expect -y

sleep 1

echo "Initializing npm project"
npm init --y

sleep 1

echo "Installing Hardhat"
npm install --save-dev hardhat

sleep 1

echo "Installing ts-node"
npm install --save-dev ts-node

sleep 1

echo "Installing typescrit"
npm install --save-dev typescript

sleep 1

npx hardhat | expect <<EOF
  spawn npx hardhat
  sleep 1
  expect "What do you want to do?" { send -- "1\r" }
  sleep 1
  expect "Hardhat project root:" { send -- "\r" }
  sleep 1
  expect "Do you want to add a .gitignore?" { send -- "y\r" }
  sleep 1
  expect "Do you want to install this sample project's dependencies with npm (@nomicfoundation/hardhat-toolbox)?" { send -- "y\r" }
  expect eof
EOF

echo "Packages1"
npm install --save dotenv

sleep 1

echo "Packages1"
npm install --save @openzeppelin/contracts

sleep 1

echo "Packages1"
npm install --save-dev @nomicfoundation/hardhat-toolbox

sleep 1

echo "Packages1"
npm install --save-dev @nomiclabs/hardhat-etherscan

sleep 1

read -p "Enter your wallet private key: " VALUE
echo "WALLET_KEY=$VALUE" >> .env

echo "Create hardhat config"
curl -o hardhat.config.ts https://raw.githubusercontent.com/Salvatorenodes/Base-smart-contract/main/hardhat.config.ts

echo "Create deploy.ts"
curl -o ./scripts/deploy.ts https://raw.githubusercontent.com/Salvatorenodes/Base-smart-contract/main/deploy.ts

read -p "Enter the Name of your smart contract(How in creating): " Contract
sed -i "s/Name/$Contract/g" ./scripts/deploy.ts

read -p "Enter the name of your smart contract (firs letter is small!!!!): " Contract
sed -i "s/name/$Contract/g" ./scripts/deploy.ts

echo "Create contract"
read -p "Enter the Name of your smart contract(How in creating): " Contractname
curl -o ./contracts/$Contractname.sol -L https://raw.githubusercontent.com/Salvatorenodes/Base-smart-contract/main/example.sol

read -p "Enter smart contract name AGAIN!: " Contract
sed -i "s/Name/$Contract/g" ./contracts/$Contract.sol

echo "Remove shit"
rm ./contracts/Lock.sol

echo "Compile"
npx hardhat compile

sleep 1

echo "Deploy"
npx hardhat run scripts/deploy.ts --network base-goerli
