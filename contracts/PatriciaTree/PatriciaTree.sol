pragma solidity ^0.4.16;
pragma experimental "v0.5.0";
pragma experimental "ABIEncoderV2";

import "./PatriciaTreeBase.sol";
import "./IPatriciaTree.sol";


/// @title Patricia tree implementation
/// @notice More info at: https://github.com/chriseth/patricia-trie
contract PatriciaTree is IPatriciaTree, PatriciaTreeBase {

  function insert(bytes key, bytes value) public {
    tree.insert(keccak256(key), value);
  }

  function getProof(bytes key) public view returns (uint branchMask, bytes32[] _siblings) {
    return getProofFunctionality(keccak256(key));
  }

  function getImpliedRoot(bytes key, bytes value, uint branchMask, bytes32[] siblings) public
  pure returns (bytes32)
  {
    return getImpliedRootHashKey(key, value, branchMask, siblings);
  }


}
