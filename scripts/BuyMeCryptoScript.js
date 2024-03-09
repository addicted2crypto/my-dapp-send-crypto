// We require the Hardhat Runtime Environment explicitly here. This is optional
// but useful for running the script in a standalone fashion through `node <script>`.
//
// You can also run a script with `npx hardhat run <script>`. If you do that, Hardhat
// will compile your contracts, add the Hardhat Runtime Environment's members to the
// global scope, and execute the script.
const hre = require("hardhat");

// Returns Balance of a given address
async function getBalance(address) {
  const balanceBigInt = await hre.waffle.provider.getBalance(address);
  return hre.ethers.utils.formatEther(balanceBigInt);
}

//Logs the Ether balances for a list of addresses.
async function printBalances(address) {
    let idx = 0;
    console.log(`Address ${idx} balance:`, await getBalance(address));
    idx++;
}

//Print and log the memos stored on-chain from coffee purchces
async function printMemos(memos) {
  for (const memo of memos) {
    const timestamp = memo.timestamp;
    const tipper = memo.name;
    const tipperAddress = memo.from;
    const message = memo.message;
    console.log(`At ${timestamp}, ${tipper} (${tipperAddress} said: "${message}"`);
  }
}



async function main() {
  // Get example accounts for tests.
  const [owner, tipper, tipper2, tipper3] = await hre.ethers.getSigners();

  //Get the contract to deploy
  const BuyMeCrypto = await hre.ethers.getContractFactory("BuyMeCrypto");
  const buyMeCrypto = await BuyMeCrypto.deploy();
 
  //Deploy the BuyMeCrypto.sol contract
  await BuyMeCrypto.deployed();
  console.log("BuyMeCrypto deployed to", BuyMeCrypto.address);

  //Check the balance of the Cypto sent.
  const addresses = [owner.address, tipper.address, BuyMeCrypto.address];
  console.log("== start ==");
  await printBalances(addresses);


  //Withdrawl funds.

  //Check the balance after withdraw.

  //Read all the memos
  };



  

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
