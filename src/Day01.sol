// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

contract Day01 {
  function solvePart1(uint256[] calldata numbers) external pure returns (uint256) {
    uint256 cur = 1;
    uint256 res = 0;
    while (cur < numbers.length) {
      if (numbers[cur - 1] < numbers[cur]) {
        res++;
      }
      cur++;
    }
    return res;
  }

  function solvePart2(uint256[] calldata numbers) external pure returns (uint256) {
    uint256[] memory num = _reduceAndSum(numbers);
    uint256 cur = 1;
    uint256 res = 0;
    while (cur < num.length) {
      if (num[cur - 1] < num[cur]) {
        res++;
      }
      cur++;
    }
    return res;
  }

  uint256[] reducedSums;

  function _reduceAndSum(uint256[] calldata numbers) internal pure returns (uint256[] memory) {
    uint256[] memory x = new uint256[](numbers.length - 2);
    uint256 cur = 2;
    while (cur < numbers.length) {
      x[cur - 2] = (numbers[cur - 2] + numbers[cur - 1] + numbers[cur]);
      cur++;
    }
    return x;
  }
}
