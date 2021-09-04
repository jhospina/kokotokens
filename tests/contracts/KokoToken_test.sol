// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

import "remix_tests.sol";
import "../../src/contracts/KokoToken.sol";

contract KokoTokenTest {

    KokoToken kokoToken;

    function beforeAll() public {
        kokoToken = new KokoToken();
    }

    function checkGetTotalSupplyIsZero() public{
        Assert.equal(0, kokoToken.getTotalSupply(), "total supply is not Zero.");
    }

}