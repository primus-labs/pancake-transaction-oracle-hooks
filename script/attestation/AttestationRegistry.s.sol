// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

import {Script} from "forge-std/Script.sol";
import "forge-std/Test.sol";
import {AttestationRegistry} from "src/attestation/AttestationRegistry.sol";

contract DeployAttestationRegistry is Script {
    function run() external {
        // private key from env
        uint256 deployerPrivateKey = vm.envUint("PRIVATE_KEY");
        vm.startBroadcast(deployerPrivateKey);

        // initialize variables from env
        address primusZKTLS = vm.envAddress("PRIMUS_ZKTLS_BSC_TEST"); // IPrimusZKTLS contract address
        uint256 submissionFee = 0; // submit fee
        address payable feeRecipient = payable(vm.envAddress("FEE_RECIPIENT")); // fee recipient

        // deploy AttestationRegistry
        AttestationRegistry attestationRegistry = new AttestationRegistry(
            primusZKTLS,
            submissionFee,
            feeRecipient
        );
        string[] memory cexUrls = new string[](3);
        cexUrls[0] = "https://www.okx.com/v3/users/fee/trading-volume-progress";
        cexUrls[1] = "https://www.bitget.com/v1/mix/vip/need";
        cexUrls[2] = "https://www.binance.com/bapi/accounts/v1/private/vip/vip-portal/vip-fee/vip-programs-and-fees";
        string[] memory cexJsonPaths = new string[](3);
        cexJsonPaths[0] = "$.data.requirements[1].currentVolume";
        cexJsonPaths[1] = "$.data.spotVol";
        cexJsonPaths[2] = "$.data.traderProgram.spotTrader.spotVolume30d";
        string[] memory cexNames = new string[](3);
        cexNames[0] = "okx";
        cexNames[1] = "bitget";
        cexNames[2] = "bsc";
        attestationRegistry.setCexCheckListAndJsonPath(cexUrls,cexNames,cexJsonPaths);

        console.log("AttestationRegistry deployed at:", address(attestationRegistry));

        vm.stopBroadcast();
    }
}

