// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import {IMorpho} from "../lib/morpho-blue/src/interfaces/IMorpho.sol";

import {Test} from "forge-std/Test.sol";
import {Counter} from "../src/Counter.sol";

contract CounterTest is Test {
    Counter public counter;

    address internal immutable OWNER = makeAddr("Owner");
    IMorpho internal morpho;

    function setUp() public {
        counter = new Counter();
        counter.setNumber(0);
    }

    function test_Increment() public {
        counter.increment();
        assertEq(counter.number(), 1);
    }

    function testFuzz_SetNumber(uint256 x) public {
        counter.setNumber(x);
        assertEq(counter.number(), x);
    }

    function testDeployMorpho() public {
        morpho = IMorpho(deployCode("Morpho.sol", abi.encode(OWNER)));
    }
}
