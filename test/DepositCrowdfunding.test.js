/* eslint-disable no-undef */
// eslint-disable-next-line no-unused-vars

import { accounts, contract } from '@openzeppelin/test-environment';

import { expect } from 'chai';

const [ buyer, seller, arbiter] = accounts;

const DepositCrowdfunding = contract.fromArtifact('DepositCrowdfunding');

describe('DepositCrowdfunding', function () {
  it('deployer is buyer', async function () {
    const deposit = await DepositCrowdfunding.new({ from: buyer });
    expect(await deposit.buyer()).to.equal(buyer);
  });
  it('deployer is seller', async function () {
    const deposit = await DepositCrowdfunding.new({ from: seller });
    expect(await deposit.seller()).to.equal(seller);
  // eslint-disable-next-line padded-blocks
  });

  it('deployer is arbiter', async function () {
    const deposit = await DepositCrowdfunding.new({ from: arbiter });
    expect(await deposit.arbiter()).to.equal(arbiter);
  // eslint-disable-next-line padded-blocks
  });

});
