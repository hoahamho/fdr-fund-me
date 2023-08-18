// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
//
import {FunWithStorage} from "../src/exampleContracts/FunWithStorage.sol";

contract DeployFunWithStorage is Script {
    function run() external returns (FunWithStorage) {
        vm.startBroadcast();
        FunWithStorage funWithStorage = new FunWithStorage();
        vm.stopBroadcast();
        printStorageData(address(funWithStorage));
        printFirstArrayElement(address(funWithStorage));
        printMappingElement(address(funWithStorage));
        return (funWithStorage);
    }

    function printStorageData(address contractAddress) public view {
        for (uint256 i = 0; i < 10; i++) {
            bytes32 value = vm.load(contractAddress, bytes32(i));
            console.log("Value at location:", i, ":");
            console.logBytes32(value);
        }
    }

    function printFirstArrayElement(address contractAddress) public view {
        bytes32 arrayStorageSlot = bytes32(uint256(2));
        bytes32 firstElementStorageSlot = keccak256(
            abi.encode(arrayStorageSlot)
        );
        bytes32 value = vm.load(contractAddress, firstElementStorageSlot);
        console.log("First element in array:");
        console.logBytes32(value);
    }

    function printMappingElement(address contractAddress) public view {
        bytes32 mappingKey = bytes32(uint256(13));
        bytes32 mappingStorageSlot = bytes32(uint256(3));
        bytes32 firstElementStorageSlot = keccak256(
            abi.encodePacked(mappingKey, mappingStorageSlot)
        );
        bytes32 value = vm.load(contractAddress, firstElementStorageSlot);
        console.log("First element in mapping:");
        console.logBytes32(value);
    }
}
