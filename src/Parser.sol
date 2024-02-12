// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

contract Parser {
  /// Some pre-typecasted ASCII constants for convenience.
  uint8 internal constant ascii_0 = uint8(bytes1("0"));
  uint8 internal constant ascii_9 = uint8(bytes1("9"));
  uint8 internal constant ascii_A = uint8(bytes1("A"));
  uint8 internal constant ascii_Z = uint8(bytes1("Z"));
  uint8 internal constant ascii_a = uint8(bytes1("a"));
  uint8 internal constant ascii_z = uint8(bytes1("z"));

  /// Only storage arrays have a .push function, so we need to keep the
  /// internal array used by the parse methods as a state variable.
  uint256[] private xsStorage;
  int256[] private xiStorage;
  string[] private tokensStorage;

  /// Convert the given string into an array of tokens.
  ///
  /// Space and newline characters act as separators.
  function parseTokens(string memory s) internal returns (string[] memory) {
    return split(s, "\n", " ", false);
  }

  /// Split the given string into an array of tokens using the given
  /// separator. Empty splits are ignored.
  function split(string memory s, bytes1 sep1) internal returns (string[] memory) {
    return split(s, sep1, 0, false);
  }

  /// Split the given string into an array of tokens using the given
  /// separator.
  ///
  /// Retain empty splits if keepEmpty is true.
  function split(string memory s, bytes1 sep1, bool keepEmpty) internal returns (string[] memory) {
    return split(s, sep1, 0, keepEmpty);
  }

  /// Split the given string into an array of tokens using the given
  /// separators.
  ///
  /// Retain empty splits if keepEmpty is true.
  function split(string memory s, bytes1 sep1, bytes1 sep2, bool keepEmpty) internal returns (string[] memory) {
    // Strings are not indexable.
    bytes memory b = bytes(s);

    // Clear the stored array, emptying it.
    delete tokensStorage;
    // Get a local reference to the storage.
    string[] storage tokens = tokensStorage;

    bytes memory token;

    bool didSeeNonSeparator = false;
    for (uint256 i = 0; i < b.length; i++) {
      if (b[i] == sep1 || b[i] == sep2) {
        // separator
        if (didSeeNonSeparator) {
          tokens.push(string(token));
          delete token;
        } else if (keepEmpty) {
          tokens.push("");
        }
        didSeeNonSeparator = false;
      } else {
        token = bytes.concat(token, b[i]);
        didSeeNonSeparator = true;
      }
    }

    if (didSeeNonSeparator) {
      tokens.push(string(token));
    }

    // The return type has data location memory, so we return a copy
    // (instead of a pointer to our internal storage).
    return tokens;
  }

  /// Convert the given string into an unsigned integer.
  ///
  /// Any non-digit character causes reversion.
  function parseUint(string memory s) internal pure returns (uint256) {
    bytes memory b = bytes(s);
    uint256 out;
    for (uint256 i = 0; i < b.length; i++) {
      uint8 ascii = uint8(b[i]);
      require(ascii >= ascii_0 && ascii <= ascii_9);
      uint256 digit = ascii - ascii_0;
      out *= 10;
      out += digit;
    }
    return out;
  }
}
