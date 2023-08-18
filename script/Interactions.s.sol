// SPDX-License-Identifier: MIT

// Fund
// Withdraw

import {Script, console} from "forge-std/Script.sol";
import {DevOpsTools} from "../lib/foundry-devops/src/DevOpsTools.sol";
import {FundMe} from "../src/FundMe.sol";

pragma solidity 0.8.18;

contract FundFundMe is Script {
    uint256 constant SEND_VALUE = 0.05 ether;

    function fundFundMe(address mostRecentDeploy) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentDeploy)).fund{value: SEND_VALUE}();
        vm.stopBroadcast();
        console.log("Fund FundMe with %s", SEND_VALUE);
    }

    function run() external {
        address mostRecentDeploy = DevOpsTools.get_most_recent_deployment(
            "FundMe", // name of the contract
            block.chainid
        );
        fundFundMe(mostRecentDeploy);
    }
}

contract WithdrawFundMe is Script {
    function withdrawFundMe(address mostRecentDeploy) public {
        vm.startBroadcast();
        FundMe(payable(mostRecentDeploy)).withdraw();
        vm.stopBroadcast();
    }

    function run() external {
        address mostRecentDeploy = DevOpsTools.get_most_recent_deployment(
            "FundMe", // name of the contract
            block.chainid
        );
        vm.startBroadcast();
        withdrawFundMe(mostRecentDeploy);
        vm.stopBroadcast();
    }
}
