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

    function checkUpdatePriceWhenIsInialStateSuccess() public {
        // Given
        bytes32 queryId = 0x00000000000000F2000000000000000000000000000000000000000000000000;
        string memory priceResult = "323.20";
        uint priceExpected = 32320;
        
        externalAPI.addResult(queryId, priceResult);
        // When 
        bool result = operation.updatePrice();
        
        // Then
        Assert.ok(result, "The result was not success");
        Assert.equal(operation.getEtherPrice(), priceExpected, "The price expected is not equals");
    }
    
    function checkUpdatePriceIsFailWhenIsNotReadyByFrecuency() public {
        // Given
        externalAPI.setCurrentTimestamp(1);
       
        // When 
        bool isReady = operation.isReadyToUpdatePrice();
        bool result = operation.updatePrice();
        
        // Then 
        Assert.ok(!result, "The result was success");
        Assert.ok(!isReady, "Is ready was true");
    }
    
    
    function checkUpdatePriceWhenLastPriceIsPassWithFrequencySuccess() public {
        // Given
        bytes32 queryId = 0x00000000000000F2000000000000000000000000000000000000000000000000;
        string memory priceResult = "4230.20";
        uint priceExpected = 423020;
       
        externalAPI.addResult(queryId, priceResult);
        
        // When (1) 
        bool result = operation.updatePrice();
        // Then (1)
        Assert.ok(result, "The result was not success");
        Assert.equal(operation.getEtherPrice(), priceExpected, "The price expected is not equals"); 
        
        // Given (2)
        bytes32 queryId2 = 0x00000000000000F2000000000000000000000000000000000000000000000000;
        string memory priceResult2 = "4232.26";
        uint priceExpected2 = 423226;
        uint timestampSecondUpdate= block.timestamp + FREQUENCY_UPDATE_PRICE;
        
        externalAPI.setCurrentTimestamp(timestampSecondUpdate);
        externalAPI.addResult(queryId2, priceResult2);
       
        // When (2)
        bool isReady = operation.isReadyToUpdatePrice();
        bool result2 = operation.updatePrice();
        
        // Then (2)
        Assert.ok(isReady, "Is ready was false");
        Assert.ok(result2, "The result was not success");
        Assert.equal(operation.getEtherPrice(), priceExpected2, "The price expected is not equals"); 
    }
    
    
    
}

