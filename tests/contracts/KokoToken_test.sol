// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

import "remix_tests.sol";
import "remix_accounts.sol";
import "../../src/contracts/KokoToken.sol";

contract KokoTokenTest {

    KokoToken kokoToken;
    address _address;

    function beforeEach() public {
        kokoToken = new KokoToken();
        _address = TestsAccounts.getAccount(0);
    }

    function checkGetTotalSupplyIsZero() public {
        Assert.equal(0, kokoToken.getTotalSupply(), "total supply is not Zero.");
    }

    function checkGetNewWalletIsSuccess() public {
        // When
        bool result = kokoToken.addNewWallet(_address);
        // Then
        Assert.ok(result, "Is Success");
    }

    function checkGetNewWalletIsFailureWhenTryAddWalletAlreadyExists() public {
        // Given
        kokoToken.addNewWallet(_address);
        // When
        try kokoToken.addNewWallet(_address) returns (bool){
            Assert.ok(false, "Must no be reached!");
        } catch (bytes memory) {
            Assert.ok(true, 'addNewWallet must be rejected by already exists');
        }
    }

}