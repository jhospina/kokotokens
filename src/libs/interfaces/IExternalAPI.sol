// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "github.com/jhospina/ethereum-provable-support-versions/provableAPI_0.8.sol";
import "./SuccessRequestListener.sol";

abstract contract IExternalAPI is usingProvable {
    function setOnSuccessListener(SuccessRequestListener _listener) virtual external;
    function requestUrl(string memory endpoint, string memory pathData) virtual external payable;
}
