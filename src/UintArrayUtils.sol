// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract UintArrayUtils {
  function reduce(
    uint256[] memory self,
    function(uint256, uint256) external pure returns (uint256) callback
  ) public pure returns (uint256) {
    uint256 accumulator = 0;
    for (uint256 i = 0; i < self.length; i++) {
      accumulator = callback(accumulator, self[i]);
    }
    return accumulator;
  }
}
