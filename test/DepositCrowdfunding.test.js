/* eslint-disable no-undef */
// eslint-disable-next-line no-unused-vars

import { accounts, contract } from '@openzeppelin/test-environment';

import { expect } from 'chai';

// eslint-disable-next-line no-unused-vars

const DepositCrowdfunding = contract.fromArtifact('DepositCrowdfunding');


describe('DepositCrowdfunding', function () {
  this.timout(0);

  const [owner, dev] = accounts;
  const MESSAGE = 'WELCOME IN THE BLOCKCHAIN';
  const _MESSAGE = 'NEW MESSAGE';

  context('DepositCrowdfunding initial state', function () {
    beforeEach(async function () {
      this.depositCrowdfunding = await DepositCrowdfunding.new(owner, MESSAGE, { from: dev });
    })

    it(`has message ${MESSAGE}`, async function () {
      expect(await this.depositCrowdfunding.getMessage()).to.equal(MESSAGE);

    })

    it('has owner', async function () {
      expect(await this.depositCrowdfunding.owner()).to.equal(owner);
    });

    context('DepositCrowdfunding functions', function () {
      beforeEach(async function () {
        this.depositCrowdfunding = await DepositCrowdfunding.new(owner, MESSAGE, { from: dev });
      });
      it('handles not finished yet', async function () {
        expect(await this.depositCrowdfunding.goodbye({ from: dev })).to.equal('not finished yet!!');
      });

      it('handles finished', async function () {
        await time.increase(time.duration.weeks(24));
        expect(await this.depositCrowdfunding.goodbye({ from: dev })).to.equal('congratulations and goodbye!!');
      });
    });
  });
