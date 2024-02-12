// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import "solidity-stringutils/src/strings.sol";

library StringUtils {
  using strings for *;

  function stringToUint256(string memory str) public pure returns (uint256 res, bool) {
    for (uint256 i = 0; i < bytes(str).length; i++) {
      if ((uint8(bytes(str)[i]) - 48) < 0 || (uint8(bytes(str)[i]) - 48) > 9) {
        return (0, false);
      }
      res += (uint8(bytes(str)[i]) - 48) * 10 ** (bytes(str).length - i - 1);
    }

    return (res, true);
  }

  function compareStrings(string memory str1, string memory str2) public pure returns (bool) {
    return keccak256(abi.encodePacked(str1)) == keccak256(abi.encodePacked(str2));
  }
}
