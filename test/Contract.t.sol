// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";
import { A, B, C } from "src/Contract.sol";

contract TestContract is Test {
    A a;
    B b;
    C c;

    function setUp() public {
        a = new A(10);
        b = new B(50);
        c = new C();
    }

    function testSuccess() public {
        // Call tryGetData with a _divisor > 1 and < 10
        // expected output is (v, "nil")
        (uint v, string memory s) = c.tryGetData(address(a), 5);
        assertEq(v, 2);
        assertEq(s, "nil");
    }

    function testCatchError() public {
        // Call tryGetData with a _divisor == 10
        // expected output is (420, "divisor too yuge!")
        (uint v, string memory s) = c.tryGetData(address(a), 10);
        assertEq(v, 420);
        assertEq(s, "divisor too yuge!");

    }

    function testCatchPanic() public {
        // Call tryGetData with a _divisor == 1
        // expected output is (c, "panic!")
        // where c is one of https://docs.soliditylang.org/en/v0.8.13/control-structures.html?highlight=Panic#panic-via-assert-and-error-via-require
        (uint v, string memory s) = c.tryGetData(address(a), 1);
        assertEq(v, 1);
        assertEq(s, "panic!");

    }

    function testCatchAll() public {
        // Call tryGetData with any value for _divisor
        // expected output is (v, "nil")
        (uint v, string memory s) = c.tryGetData(address(b), 5);
        assertEq(v, 1337);
        assertEq(s, "catch all!");
    }
}
