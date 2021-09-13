async function main() {
  const [owner, randoPerson] = await ethers.getSigners()
  const waveContractFactory = await hre.ethers.getContractFactory("WavePortal")
  const waveContract = await waveContractFactory.deploy()
  await waveContract.deployed()
  console.log("Contract deployed to: ", waveContract.address)
  console.log("Contract deployed by: ", owner.address)

  let waveCount
  waveCount = await waveContract.getTotalWaves()

  let waveTxn = await waveContract.wave("Hello World!")
  await waveTxn.wait()

  waveTxn = await waveContract.connect(randoPerson).wave("Another random message!")
  await waveTxn.wait()

  let allWaves = await waveContract.getAllWaves()
  console.log(allWaves)
}

main()
.then(() => process.exit(0))
.catch((error) => {
  console.error(error)
  process.exit(1)
})