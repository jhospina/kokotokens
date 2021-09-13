// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

interface SuccessRequestListener {
    function onSuccess(string memory result) external;
}
