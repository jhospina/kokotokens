// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "github.com/jhospina/ethereum-provable-support-versions/provableAPI_0.8.sol";

abstract contract IExternalAPI is usingProvable {

    function onSuccess(string memory result) virtual external;

    function requestUrl(string memory endpoint, string memory pathData) virtual external payable;
}
