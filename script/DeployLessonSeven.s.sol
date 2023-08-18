// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.18;

import {Script, console} from "forge-std/Script.sol";
// import {HelperConfig} from "./HelperConfig.s.sol";
import {LessonSeven} from "../src/exampleContracts/LessonSeven.sol";

contract DeployFunWithStorage is Script {
    LessonSeven lessonSeven;

    function run() external returns (LessonSeven) {
        vm.startBroadcast();
        lessonSeven = LessonSeven(0xD7D127991c6A89Df752FC3daeC17540aE8B86101);
        vm.stopBroadcast();
        vm.prank(0x72DBb3bD1301509A8a9349488C0139530e86D83B);
        challengerSolves(address(lessonSeven));
        return (lessonSeven);
    }

    function challengerSolves(address contractAddress) public {
        bytes32 value = vm.load(contractAddress, bytes32(uint256(777)));
        lessonSeven.solveChallenge(uint256(value), "Hoahamho1");
        console.log("Value at location 777:");
        console.logBytes32(value);
    }
}
