module.exports = {
  networks: {
    development: {
      host: "localhost",
      port: 8545,
      network_id: "*"
    },
    live: {
      host: "localhost",
      from: "0x798b0a600cd5698eb5d3e853444a384fa36fe12e",
      port: 8545,
      network_id: 1,
      gas: 6712388
    },
    rinkeby: {
      host: "localhost",
      from: "0x798b0a600cd5698eb5d3e853444a384fa36fe12e",
      port: 8545,
      network_id: 4,
      gas: 4612388
    }
  },
  solc: {
    optimizer: {
      enabled: true,
      runs: 200
    }
  }
}
