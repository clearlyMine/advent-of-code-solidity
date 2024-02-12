// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

import { Parser } from "./Parser.sol";
import { StringUtils } from "./StringUtils.sol";
import { console2 } from "forge-std/src/console2.sol";

contract Day02 is Parser {
  function _parseInput(string calldata input) internal returns (int256[2][] memory) {
    string[] memory tokens = parseTokens(input);
    int256[2][] memory out = new int256[2][](tokens.length / 2);

    for (uint256 i = 0; i < tokens.length; i += 2) {
      int256 distance = int256(parseUint(tokens[i + 1]));
      string memory direction = tokens[i];
      if (StringUtils.compareStrings(direction, "forward")) {
        out[i / 2] = [distance, 0];
      } else if (StringUtils.compareStrings(direction, "up")) {
        out[i / 2] = [int32(0), -distance];
      } else if (StringUtils.compareStrings(direction, "down")) {
        out[i / 2] = [int32(0), distance];
      }
    }
    return out;
  }

  function solvePart1(string calldata input) external returns (uint256) {
    int256[2][] memory values = _parseInput(input);
    int256[2] memory acc = [int256(0), int256(0)];
    for (uint256 i = 0; i < values.length; i++) {
      acc[0] += values[i][0];
      acc[1] += values[i][1];
    }
    return uint256(acc[0] * acc[1]);
  }

  function solvePart2(string calldata input) external returns (uint256) {
    int256[2][] memory values = _parseInput(input);
    int256[3] memory acc = [int256(0), int256(0), int256(0)];
    for (uint256 i = 0; i < values.length; i++) {
      int256 x = values[i][0];
      int256 y = values[i][1];
      if (x > 0) {
        acc[0] += x;
        acc[1] += acc[2] * x;
      } else {
        acc[2] += y;
      }
    }
    return uint256(acc[0] * acc[1]);
  }
}
