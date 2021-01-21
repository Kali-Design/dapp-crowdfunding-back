
/* eslint-disable no-unused-expressions */
const { accounts, contract } = require('@openzeppelin/test-environment');

const { time } = require('@openzeppelin/test-helpers');

const { expect } = require('chai');

const DepositCrowdfunding = contract.fromArtifact('DepositCrowdfunding ');

describe('Crowdfunting', async function () {
  const [dev, owner, user1] = accounts;
  const MESSAGE = 'WELCOME TO MY COURSES';
  const _MESSAGE = 'NEW MESSAGE';

  context('Crowdfunding initial state', function () {
    // Execute this before each tests
    beforeEach(async function () {
      this.depositcrowdfunding = await DepositCrowdfunding.new(owner, MESSAGE, { from: dev });
    });

    it(`has message ${MESSAGE}`, async function () {
      expect(await this.depositcrowdfunding.getMessage()).to.equal(MESSAGE);
    });

    it('has owner', async function () {
      expect(await this.depositcrowdfunding.owner()).to.equal(owner);
    });

    it('has starting date', async function () {
      const _current = await time.latest();
      expect(await this.DepositCrowdfunding.getStartDate()).to.be.a.bignumber.equal(_current);
    });
  });

  context('Crowdfunding ownership', function () {
    beforeEach(async function () {
      this.depositcrowdfunding = await DepositCrowdfunding.new(owner, MESSAGE, { from: dev });
    });
    it('set message', async function () {
      await this.depositcrowdfunding.setMessage(_MESSAGE, { from: owner });
      expect(await this.depositcrowdfunding.getMessage()).to.equal(_MESSAGE);
    });
  });
  context('Crowdfunding time functions', function () {
    beforeEach(async function () {
      this.formation = await DepositCrowdfunding.new(owner, MESSAGE, { from: dev });
    });
    it('handles not finished yet', async function () {
      expect(await this.depositcrowdfunding.goodbye({ from: user1 })).to.equal('not finished yet!!');
    });

    it('handles finished courses', async function () {
      await time.increase(time.duration.weeks(24));
      expect(await this.depositcrowdfunding.goodbye({ from: user1 })).to.equal('congratulations and goodbye!!');
    });
  });
});
