var PrayerCoin = artifacts.require("PrayerCoin");

contract("PrayerCoin", (accounts) => {
    const acc1 = accounts[1];
    const acc2 = accounts[2];
    const acc3 = accounts[3];
    const acc4 = accounts[4];
    const acc5 = accounts[5];
    it("First account should recieve 666,666,666 tokens", async () => {
        var meta = await PrayerCoin.deployed();
        var godBalance = await meta.balanceOf.call(accounts[0]);
        assert.equal(godBalance.valueOf(), 666666666, "666,666,666 not in first account");
    })
    it("Rates correct (11066, 7106, 6666)", async () => {
        var meta = await PrayerCoin.deployed();
        await meta.sendTransaction({ from: acc1, value: web3.toWei(5, "ether") });
        var acc1balance = await meta.balanceOf.call(acc1);
        assert.equal(web3.fromWei(acc1balance.valueOf(), 'ether'), 5 * 11066, "not workrkk");
        await meta.sendTransaction({ from: acc2, value: web3.toWei(9, "ether") });
        var acc2balance = await meta.balanceOf.call(acc2);
        assert.equal(web3.fromWei(acc2balance.valueOf(), 'ether'), 9 * 11066, "not workrkk");
        await meta.sendTransaction({ from: acc3, value: web3.toWei(50, "ether") });
        await meta.sendTransaction({ from: acc5, value: web3.toWei(50, "ether") });
        var acc3balance = await meta.balanceOf.call(acc3);
        assert.equal(web3.fromWei(acc3balance.valueOf(), 'ether'), 50 * 7106, "not workrkk");
        console.log(await meta.totalPrayers.call())
        await meta.sendTransaction({ from: acc4, value: web3.toWei(50, "ether") });
        var acc4balance = await meta.balanceOf.call(acc4);
        assert.equal(web3.fromWei(acc4balance.valueOf(), 'ether'), 50 * 6666, "not workrkk");
    })
})
