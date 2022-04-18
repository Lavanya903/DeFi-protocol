const DappToken = artifacts.require('DappToken');
const DaiToken = artifacts.require('DaiToken');
const TokenFarm = artifacts.require('TokenFarm');
module.exports =  async function(deployer,network,accounts) {
//deploy mock dai token
  await deployer.deploy(DaiToken)
  const daiToken=await DaiToken.deployed()
  await deployer.deploy(DappToken)
  const dappToken=await DappToken.deployed()
  await deployer.deploy(TokenFarm,dappToken.address,daiToken.address)
  const tokenFarm=await TokenFarm.deployed()
  //tramsfer all tokens to tokenfarm(1 million)
  await dappToken.transfer(tokenFarm.address,'1000000000000000000000000')
  //transfer 100 mock dai tokens to investertr
  await daiToken.transfer(accounts[1],'1000000000000000000000000')




}
