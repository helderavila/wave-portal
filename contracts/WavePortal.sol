// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
  uint totalWaves;
  uint private seed;

  event NewWave(address indexed from, uint timestamp, string message);

  struct Wave {
    address waver;
    string message;
    uint timestamp;
  }

  Wave[] waves;

  mapping(address => uint) public lastWavedAt;

  constructor() payable {
    console.log("Hello World!");
  }

  function wave(string memory _message) public {

    require(lastWavedAt[msg.sender] + 15 minutes < block.timestamp, "Wait 15m");

    lastWavedAt[msg.sender] = block.timestamp;

    totalWaves += 1;
    console.log("%s is waved", msg.sender);
    console.log("Got message: %s", msg.sender);
    waves.push(Wave(msg.sender, _message, block.timestamp));
    
    uint randomNumber = (block.difficulty + block.timestamp + seed) % 100;
    console.log("Random # generated: %s", randomNumber);

    seed = randomNumber;

    if (randomNumber < 50) {
      console.log("%s won!", msg.sender);

      uint prizeAmount = 0.001 ether;
      require(prizeAmount <= address(this).balance, "Contract doesn't have money");
      (bool success,) = (msg.sender).call{value: prizeAmount}("");
      require(success, "Failed to send money");
    }
  }

  function getAllWaves() view public returns (Wave[] memory) {
    return waves;
  }

  function getTotalWaves() view public returns (uint) {
    return totalWaves;
  }
}