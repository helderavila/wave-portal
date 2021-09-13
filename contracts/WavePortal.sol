// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.4;

import "hardhat/console.sol";

contract WavePortal {
  uint totalWaves;

  event NewWave(address indexed from, uint timestamp, string message);

  struct Wave {
    address waver;
    string message;
    uint timestamp;
  }

  Wave[] waves;

  constructor() {
    console.log("Hello World!");
  }

  function wave(string memory _message) public {
    totalWaves += 1;
    console.log("%s is waved", msg.sender);

    waves.push(Wave(msg.sender, _message, block.timestamp));

    emit NewWave(msg.sender, block.timestamp, _message);
  }

  function getAllWaves() view public returns (Wave[] memory) {
    return waves;
  }

  function getTotalWaves() view public returns (uint) {
    return totalWaves;
  }
}