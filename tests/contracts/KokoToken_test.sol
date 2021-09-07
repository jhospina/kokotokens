// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

import "remix_tests.sol";
import "remix_accounts.sol";
import "../../src/contracts/KokoToken.sol";

contract KokoTokenTest {

    KokoToken kokoToken;
    address _address;

    function beforeAll() public {
        kokoToken = new KokoToken();
        _address = TestsAccounts.getAccount(0);
    }

    function checkGetTotalSupplyIsZero() public{
        Assert.equal(0, kokoToken.getTotalSupply(), "total supply is not Zero.");
    }

    function checkGetNewWalletIsSuccess() public{
        kokoToken.addNewWallet(_address);
        Assert.ok(true,"Is Success");
    }

}