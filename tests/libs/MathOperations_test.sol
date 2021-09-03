// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

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

        } catch (bytes memory) {
            Assert.ok(true, 'overflow expected');
        }
    }

    function checkSubtracIsSuccess() public {
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

        } catch (bytes memory) {
            Assert.ok(true, 'overflow expected');
        }
    }

}
