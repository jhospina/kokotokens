// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

interface BaseToken {
    function getTotalSupply() external view returns (uint);

    function addNewWallet(address _address) external returns (bool);
    
    function increaseWalletBalanceSender(uint amount) external;
}
