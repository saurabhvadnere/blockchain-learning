// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract BasicMerkleTree {

    bytes32 public merkleRoot;

    constructor(bytes32 _merkleRoot) {
        merkleRoot = _merkleRoot;
    }

    // Verify Merkle Proof
    function verify(
        bytes32[] calldata proof,
        bytes32 leaf
    ) public view returns (bool) {

        bytes32 hash = leaf;

        for (uint256 i = 0; i < proof.length; i++) {
            bytes32 proofElement = proof[i];

            if (hash <= proofElement) {
                hash = keccak256(abi.encodePacked(hash, proofElement));
            } else {
                hash = keccak256(abi.encodePacked(proofElement, hash));
            }
        }

        return hash == merkleRoot;
    }

    // Helper: create leaf from address
    function getLeaf(address user) public pure returns (bytes32) {
        return keccak256(abi.encodePacked(user));
    }
}
