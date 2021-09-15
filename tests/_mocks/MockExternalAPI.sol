// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "../../src/contracts/operations/UpdateEtherPriceOperation.sol";
import "../../src/libs/interfaces/IExternalAPI.sol";
import "../../src/libs/interfaces/SuccessRequestListener.sol";

contract MockExternalAPI is IExternalAPI {

    SuccessRequestListener listener;

    mapping(bytes32 => string) results;
    bytes32[] resultKeys;

    function setOnSuccessListener(SuccessRequestListener _listener) external override {
        listener = _listener;
    }

    function addResult(bytes32 queryId, string memory _result) external {
        results[queryId] = _result;
        resultKeys.push(queryId);
    }

    mapping(bytes32 => bool) internal idQueries;

    function requestUrl(string memory endpoint, string memory pathData) external override payable {
        (string memory result, bytes32 resultLastKey, uint index) = this.getLastResult();
        removeResult(resultLastKey, index);
        this.__callback(resultLastKey, result);
    }

    function __callback(bytes32 queryId, string memory result) override public {
        listener.onSuccess(result);
    }

    function getLastResult() external view returns (string memory, bytes32, uint){
        bytes32 lastKey = resultKeys[resultKeys.length - 1];
        return (results[lastKey], lastKey, resultKeys.length - 1);
    }

    function removeResult(bytes32 key, uint index) internal {
        delete resultKeys[index];
        delete results[key];
    }
    
    function _getContractAddress() external override returns (address){
        return address(this);
    }
}


