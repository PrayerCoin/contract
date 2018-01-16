var PrayerCoin = artifacts.require("PrayerCoin");

contract("PrayerCoin", (accounts) => {
    it("First account should recieve 666,666,666 tokens", async () => {
        var meta = await PrayerCoin.deployed();
        var godBalance = await meta.balanceOf.call(accounts[0]);
        assert.equal(godBalance.valueOf(), 666666666, "666,666,666 not in first account");
    })
})
