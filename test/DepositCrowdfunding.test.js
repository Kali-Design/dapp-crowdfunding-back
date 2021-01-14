/* eslint-disable no-undef */
// eslint-disable-next-line no-unused-vars

import { accounts, contract } from '@openzeppelin/test-environment';

import { expect } from 'chai';

// eslint-disable-next-line no-unused-vars
const [ owner, deposit ] = accounts;

const DepositCrowdfunding = contract.fromArtifact('DepositCrowdfunding');

describe('DepositCrowdfunding', function () {
  it('deployer is owner', async function () {
    const owner = await DepositCrowdfunding.new({ from: owner });
    expect(await deposit.owner()).to.equal(owner);
  });
  it('deployer is deposit', async function () {
    // eslint-disable-next-line no-unused-vars
    const deposit = await DepositCrowdfunding.new({ from: owner });
    expect(await deposit.owner()).to.equal(owner);
  // eslint-disable-next-line padded-blocks
  });

  it('deployer is withdraw', async function () {
    const withdraw = await DepositCrowdfunding.new({ from: owner });
    expect(await withdraw.owner()).to.equal(owner);
  // eslint-disable-next-line padded-blocks
  });

});
