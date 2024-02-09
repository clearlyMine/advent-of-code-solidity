// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.23 <0.9.0;

import { PRBTest } from "@prb/test/src/PRBTest.sol";
import { console2 } from "forge-std/src/console2.sol";
import { StdCheats } from "forge-std/src/StdCheats.sol";
import { Test } from "forge-std/src/Test.sol";
// import { Vm } from "forge-std/src/Vm.sol";

import { Day01 } from "../src/Day01.sol";
import { StringUtils } from "../src/StringUtils.sol";

interface IERC20 {
  function balanceOf(address account) external view returns (uint256);
}

/// @dev If this is your first time with Forge, read this tutorial in the Foundry Book:
/// https://book.getfoundry.sh/forge/writing-tests
contract Day01Test is StdCheats, Test {
  Day01 internal day01;
  StringUtils stringUtils;
  string path = "./inputs/day01.txt";
  string sample_path = "./inputs/day01_sample.txt";
  uint256[] inputs;

  /// @dev A function invoked before each test case is run.
  function setUp() public virtual {
    assertTrue(vm.exists(sample_path));
    assertTrue(vm.exists(path));
    // Instantiate the contract-under-test.
    day01 = new Day01();
    stringUtils = new StringUtils();
  }

  function _parseInput(string storage p) internal returns (uint256[] memory) {
    while (true) {
      string memory line = vm.readLine(p);
      if (bytes(line).length == 0) {
        break;
      }

      (uint256 num, bool res) = stringUtils.stringToUint256(line);
      assertTrue(res);
      inputs.push(num);
    }
    return inputs;
  }

  function test_day01_part_1_sample() public {
    uint256[] memory i = _parseInput(sample_path);
    uint256 part1 = day01.solvePart1(i);

    console2.log("Part 1 sample: part1");
    assertEq(part1, 7);
  }

  function test_day01_part_1() public {
    uint256[] memory i = _parseInput(path);
    uint256 part1 = day01.solvePart1(i);

    console2.log("Part 1: part1");
    assertEq(part1, 1722);
  }

  function test_day01_part_2_sample() public {
    uint256[] memory i = _parseInput(sample_path);
    uint256 part2 = day01.solvePart2(i);

    console2.log("Part 2 sample: part2");
    assertEq(part2, 5);
  }

  function test_day01_part_2() public {
    uint256[] memory i = _parseInput(path);
    uint256 part2 = day01.solvePart2(i);

    console2.log("Part 2: part2");
    assertEq(part2, 1748);
  }
}
