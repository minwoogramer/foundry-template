//SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import { Test } from "forge-std/src/Test.sol";
import { Deposit } from "../src/Deposit.sol";
import { MyMockERC20 } from "../src/MyMockERC20.sol";
import { SigUtils } from "../src/SigUtils.sol";

contract DepositTest is Test {
    Deposit internal deposit;
    MyMockERC20 internal token;
    SigUtils internal sigUtils;

    uint256 internal ownerPrivateKey;
    address internal owner;

    function setUp() public {
        deposit = new Deposit();
        token = new MyMockERC20();
        sigUtils = new SigUtils(token.DOMAIN_SEPARATOR());

        ownerPrivateKey = 0xA11CE;
        owner = vm.addr(ownerPrivateKey); //getOwnerAddress(ownerPrivateKey);

        token.mint(owner, 1e18);
    }

    function test_DepositWithLimitedPermit() public {
        SigUtils.Permit memory permit = SigUtils.Permit({
            owner: owner,
            spender: address(deposit),
            value: 1e18,
            nonce: token.nonces(owner),
            deadline: block.timestamp + 1 days
        });

        bytes32 digest = sigUtils.getTypedDataHash(permit);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, digest); //getSign(ownerPrivateKey, digest);

        deposit.depositWithPermit(
            address(token), 1e18, permit.owner, permit.spender, permit.value, permit.deadline, v, r, s
        );

        assertEq(token.balanceOf(owner), 0);
        assertEq(token.balanceOf(address(deposit)), 1e18);

        assertEq(token.allowance(owner, address(deposit)), 0);
        assertEq(token.nonces(owner), 1);

        assertEq(deposit.userDeposits(owner, address(token)), 1e18);
    }

    function test_DepositWithMaxPermit() public {
        SigUtils.Permit memory permit = SigUtils.Permit({
            owner: owner,
            spender: address(deposit),
            value: type(uint256).max,
            nonce: token.nonces(owner),
            deadline: block.timestamp + 1 days
        });

        bytes32 digest = sigUtils.getTypedDataHash(permit);

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(ownerPrivateKey, digest);

        deposit.depositWithPermit(
            address(token), 1e18, permit.owner, permit.spender, permit.value, permit.deadline, v, r, s
        );

        assertEq(token.balanceOf(owner), 0);
        assertEq(token.balanceOf(address(deposit)), 1e18);

        assertEq(token.allowance(owner, address(deposit)), type(uint256).max);
        assertEq(token.nonces(owner), 1);

        assertEq(deposit.userDeposits(owner, address(token)), 1e18);
    }
}
