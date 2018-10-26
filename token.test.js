const BigNumber = web3.BigNumber;
const should = require('chai')
  .use(require('chai-as-promised'))
  .use(require('chai-bignumber')(BigNumber))
  .should();

var DefaultToken = artifacts.require('Token');


const BN_ZERO = new BigNumber(0);
const DECIMAL = 10**18;

contract('Default test', async (accounts) => {

    let instance;
    
    beforeEach("Before Test", async() =>{
        instance = await DefaultToken.new();
    });

    afterEach("After Each", async() => {

    });


    it("The token transfer must increase the balance of the recipient.", async function() {

        let value = 100*DECIMAL;
        await instance.transfer( accounts[1], value ).should.be.fulfilled; 

        expect( await instance.balanceOf( accounts[1]) ).to.deep.equal( new BigNumber(value) );

    });

    it("The token transfer must reduce the balance of the sender.", async function() {
        let value = 100

        await instance.transfer( accounts[1], value ).should.be.fulfilled; 
        expect( await instance.balanceOf( accounts[1]) ).to.deep.equal( new BigNumber(value) );

        await instance.transfer( accounts[3], 30 ,{from: accounts[1]}).should.be.fulfilled; 
        expect( await instance.balanceOf( accounts[1]) ).to.deep.equal( new BigNumber(value-30) );
        expect( await instance.balanceOf( accounts[3]) ).to.deep.equal( new BigNumber(30) );

    });

    it("Transmission beyond balance should reject", async function() {

        let value = 100

        await instance.transfer( accounts[1], value ).should.be.fulfilled; 
        expect( await instance.balanceOf( accounts[1]) ).to.deep.equal( new BigNumber(value) );

        await instance.transfer( accounts[3], value+1 ,{from: accounts[1]}).should.be.rejectedWith('revert');; 
        expect( await instance.balanceOf( accounts[1]) ).to.deep.equal( new BigNumber(value) );
        expect( await instance.balanceOf( accounts[3]) ).to.deep.equal( BN_ZERO );

    });

    it("When the request account has no token returns zero", async function() {

        expect( await instance.balanceOf( accounts[9]) ).to.deep.equal( BN_ZERO );

    });

    it("when there was no approved amount before approves the requested amount", async function() {
        const amount = 100;

        await instance.approve(accounts[1], amount, { from: accounts[0] });

        const allowance = await instance.allowance(accounts[0], accounts[1]);
        assert.equal(allowance, amount);

    });

    it("approve valau can be changed", async function() {
        const amount = 100;
        const newAmount = 200

        await instance.approve(accounts[1], amount, { from: accounts[0] });

        const allowance = await instance.allowance(accounts[0], accounts[1]);
        assert.equal(allowance, amount);

        await instance.approve(accounts[1], newAmount, { from: accounts[0] });

        const newAllowance = await instance.allowance(accounts[0], accounts[1]);
        assert.equal(newAllowance, newAmount);
        assert.notEqual(newAllowance,allowance);

    });

    it("spender can transfer tokens under allowed amount", async function() {
        const amount = 100;

        await instance.approve(accounts[1], amount, { from: accounts[0] });

        await instance.transferFrom(accounts[0], accounts[3], amount,{from :accounts[1]}).should.be.fulfilled;

    });

    it("spender can't transfer tokens exceed allowed amount", async function() {
        const amount = 100;

        await instance.approve(accounts[1], amount, { from: accounts[0] });                
        await instance.transferFrom(accounts[0], accounts[3], amount+1 ,{from :accounts[1]}).should.be.rejectedWith('revert');
    });

    it("transferFrom can transfer tokens under balance of owners", async function() {
        const amount = 100;
        const approval = 1000;
        await instance.transfer(accounts[1], amount);

        await instance.approve(accounts[3], approval, { from: accounts[1] });                
        await instance.transferFrom(accounts[1], accounts[4], amount ,{from :accounts[3]}).should.be.fulfilled;
    });

    it("transferFrom can't transfer tokens exceed balance of owners", async function() {
        const amount = 100;
        const approval = 1000;
        await instance.transfer(accounts[1], amount);

        await instance.approve(accounts[3], approval, { from: accounts[1] });                
        await instance.transferFrom(accounts[1], accounts[4], amount+1 ,{from :accounts[3]}).should.be.rejectedWith('revert');
    });
});

