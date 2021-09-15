// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "remix_tests.sol";
import "../../../src/contracts/operations/UpdateEtherPriceOperation.sol";
import "../../../src/libs/interfaces/IExternalAPI.sol";
import "../../_mocks/MockExternalAPI.sol";

contract UpdateEtherPriceOperationTest {

    UpdateEtherPriceOperation operation;
    MockExternalAPI externalAPI;

    function beforeEach() public {
        externalAPI = new MockExternalAPI();
        operation = new UpdateEtherPriceOperation(externalAPI);
    }

    function checkUpdatePriceSuccess() public {
        // Given
        bytes32 queryId = 0x00000000000000F2000000000000000000000000000000000000000000000000;
        string memory priceResult = "323.20";
        uint priceExpected = 32320;

        externalAPI.addResult(queryId, priceResult);
        // When 
        operation.updatePrice();
        // Then
        Assert.equal(operation.getEtherPrice(), priceExpected, "The price expected is not equals");
    }
}

