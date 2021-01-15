const DepositCrowdfunding = artifacts.require('DepositCrowdfunding');

module.exports = async (deployer, accounts) => {
  await deployer.deploy(DepositCrowdfunding, accounts[0], { from: accounts[0] });
};
