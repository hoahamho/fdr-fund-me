// SPDX-License-Identifier: MIT
pragma solidity 0.8.18;
import {Test, console} from "forge-std/Test.sol";
import {FundMe} from "../src/FundMe.sol";
import {DeployFundMe} from "../script/DeployFundMe.s.sol";

contract FundMeTest is Test {
    FundMe fundMe;

    function setUp() external {
        DeployFundMe deployFundMe = new DeployFundMe();
        fundMe = deployFundMe.run();
    }

    function testMinimumDollar() public {
        assertEq(fundMe.MINIMUM_USD(), 5e18);
    }

    function testOwnerIsMsgSender() public {
        assertEq(fundMe.i_owner(), msg.sender);
    }

    function testVersion() public {
        assertEq(fundMe.getVersion(), 4);
    }

    function testFundFailsNotEnoughETH() public {
        vm.expectRevert(); // hey, the next line, should revert.
        fundMe.fund();
    }

    function testFundUpdateData() public {
        fundMe.fund{value: 10e18}();
        address funder;
        funder = fundMe.getFunder(0);
        assertEq(fundMe.getAddressToAmountFunded(funder), 10e18);
    }
}
