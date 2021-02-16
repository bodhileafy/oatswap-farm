const { assert } = require("chai");

const OatToken = artifacts.require('OatToken');

contract('OatToken', ([alice, bob, carol, dev, minter]) => {
    beforeEach(async () => {
        this.oat = await OatToken.new({ from: minter });
    });


    it('mint', async () => {
        await this.oat.mint(alice, 1000, { from: minter });
        assert.equal((await this.oat.balanceOf(alice)).toString(), '1000');
    })
});
