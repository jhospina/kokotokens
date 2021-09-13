// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "remix_tests.sol";
import "../../src/libs/MathOperations.sol";
import "../../src/libs/Constants.sol";

contract MathOperationsTest {

    using MathOperations for uint;

    function checkSumIsSuccess() public {
        // Give
        uint valueA = 123000;
        uint valueB = 223888;
        uint expected = valueA + valueB;

        // When
        uint result = valueA.sum(valueB);
        // Then
        Assert.equal(expected, result, "The sum is wrong!");
    }

    function checkSumIsOverflow() public {
        try INT_MAX.sum(100) returns (uint){
            Assert.ok(false, "No reached!");
        } catch (bytes memory) {
            Assert.ok(true, 'overflow expected');
        }
    }

    function checkSubtractIsSuccess() public {
        // Give
        uint valueA = 500;
        uint valueB = 51;
        uint expected = valueA - valueB;

        // When
        uint result = valueA.subtract(valueB);
        // Then
        Assert.equal(expected, result, "The subtract is wrong!");
    }

    function checkSubtractIsOverflow() public {
        try INT_MIN.subtract(200) returns (uint){
            Assert.ok(false, "No reached!");
        } catch (bytes memory) {
            Assert.ok(true, 'overflow expected');
        }
    }

    function checkMultiplyIsSuccess() public {
        // Give
        uint valueA = 123;
        uint valueB = 10;
        uint expected = valueA * valueB;

        // When
        uint result = valueA.multiply(valueB);
        // Then
        Assert.equal(expected, result, "The multiply is wrong!");
    }

    function checkMultiplyIsZero() public {
        // Give
        uint valueA = 0;
        uint valueB = 0;
        uint expected = 0;

        // When
        uint result = valueA.multiply(valueB);
        // Then
        Assert.equal(expected, result, "The multiply is wrong!");
    }

    function checkMultiplyIsOverflow() public {
        try INT_MAX.multiply(INT_MAX) returns (uint){
            Assert.ok(false, "No reached!");
        } catch (bytes memory) {
            Assert.ok(true, 'overflow expected');
        }
    }

}
