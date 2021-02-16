const { assert } = require("chai");

const OatToken = artifacts.require('OatToken');

contract('OatToken', ([alice, bob, carol, dev, minter]) => {
    beforeEach(async () => {
        this.oat = await OatToken.new({ from: minter });
    });


    it('mint', async () => {
        await this.oat.mint(alice, 1000, { from: minter });
        assert.equal((await this.oat.balanceOf(alice)).toString(), '1000');
    });

    it('burn', async () => {
        await this.oat.mint(alice, 1000, { from: minter });
        await this.oat.mint(bob, 1000, { from: minter });
        assert.equal((await this.oat.totalSupply()).toString(), '2000');
        assert.equal((await this.oat.totalBurned()).toString(), '0');
        await this.oat.burn(200, { from: alice });
        assert.equal((await this.oat.balanceOf(alice)).toString(), '800');
        assert.equal((await this.oat.totalSupply()).toString(), '1800');
        assert.equal((await this.oat.totalBurned()).toString(), '200');
    });
});
