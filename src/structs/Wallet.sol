// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

struct Wallet {
    // Indicates the wallet address
    address _address;
    
    /**
     *  Storages the currency amount in a value of 10^2 decimals. 
     *  Examples:
     *      * 1000 => 10,00
     *      * 2099 => 20,99
     */
    uint balance; 
}