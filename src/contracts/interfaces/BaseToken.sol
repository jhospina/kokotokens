// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

interface BaseToken {
    function getTotalSupply() external view returns (uint);

    function addNewWallet() external;
    
    function increaseWalletBalanceSender(uint amount) external;
    
}
