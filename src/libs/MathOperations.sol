// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

library MathOperations {

    function subtract(uint a, uint b) external pure returns (uint) {
        assert(b <= a);
        return a - b;
    }

    function sum(uint a, uint b) external pure returns (uint) {
        uint c = a + b;
        assert(c >= a);
        return c;
    }

    function multiply(uint a, uint b) external pure returns (uint) {
        if (a == 0) {
            return 0;
        }

        uint c = a * b;
        require(c / a == b, "MathOperations: multiplication overflow");

        return c;
    }
}

