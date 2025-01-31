// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.24;

struct Attestation {
    // The address of the user who made the attestation
    address recipient;
    // The cex name(such as binance, okex, ) of the attestation
    string exchange;
    // The value of the attestation
    uint32 value;
    // The timestamp of the attestation
    uint256 timestamp;
}
