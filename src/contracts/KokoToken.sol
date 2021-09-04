// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

import "./interfaces/BaseToken.sol";
import "../structs/Wallet.sol";
import "../libs/Constants.sol";
import "../libs/MathOperations.sol";

contract KokoToken is BaseToken {
    
    using MathOperations for uint;
    
    string public constant name = "Koko";
    string public constant symbol = "KOK";
    uint8 public constant decimals = 18;
    
    uint private totalSupply = 0;
    
    mapping(address => Wallet) accounts;
    
    function getTotalSupply() override external view returns (uint){
        return totalSupply;
    }
    
    function addNewWallet() override external{
        
        address _address = msg.sender;
        Wallet memory wallet = Wallet(_address, 0);
        
        require(accounts[_address].balance==0, "Wallet address already exists");
        
        accounts[_address] = wallet;
    }
    
    function increaseWalletBalanceSender(uint amount) override external {
        
        uint currentBalance = accounts[msg.sender].balance;
        
        accounts[msg.sender].balance = currentBalance.sum(amount);
        increaseTotalSupply(amount);
    }
    
    function increaseTotalSupply(uint amount) private {
        totalSupply = totalSupply.sum(amount);
    }
    
    function decreaseTotalSupply(uint amount) private {
        totalSupply = totalSupply.subtract(amount);
    }
}
