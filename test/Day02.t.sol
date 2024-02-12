// SPDX-License-Identifier: UNLICENSED
pragma solidity >=0.8.23 <0.9.0;

import { console2 } from "forge-std/src/console2.sol";
import { StdCheats } from "forge-std/src/StdCheats.sol";
import { Test } from "forge-std/src/Test.sol";
import { Day02 } from "../src/Day02.sol";

interface IERC20 {
  function balanceOf(address account) external view returns (uint256);
}

/// @dev If this is your first time with Forge, read this tutorial in the Foundry Book:
/// https://book.getfoundry.sh/forge/writing-tests
contract Day02Test is StdCheats, Test {
  Day02 internal day02;
  string path = "./inputs/day02.txt";
  string sample_path = "./inputs/day02_sample.txt";

  /// @dev A function invoked before each test case is run.
  function setUp() public virtual {
    assertTrue(vm.exists(sample_path));
    assertTrue(vm.exists(path));
    // Instantiate the contract-under-test.
    day02 = new Day02();
  }

  function test_day02_part_1_sample() public {
    string memory _i = vm.readFile(sample_path);
    uint256 _part1_sample = day02.solvePart1(_i);

    console2.log("Part 1 sample: %d", _part1_sample);
    assertEq(_part1_sample, 150);
  }

  function test_day02_part_1() public {
    string memory _i = vm.readFile(path);
    uint256 _part1 = day02.solvePart1(_i);

    console2.log("Part 1: %d", _part1);
    assertEq(_part1, 1840243);
  }

  function test_day02_part_2_sample() public {
    string memory _i = vm.readFile(sample_path);
    uint256 _part2_sample = day02.solvePart2(_i);

    console2.log("Part 2 sample: %d", _part2_sample);
    assertEq(_part2_sample, 900);
  }

  function test_day02_part_2() public {
    string memory _i = vm.readFile(path);
    uint256 _part2 = day02.solvePart2(_i);

    console2.log("Part 2: %d", _part2);
    assertEq(_part2, 1727785422);
  }
}
