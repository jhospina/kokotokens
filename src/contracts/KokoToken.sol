// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0;

import "./interfaces/BaseToken.sol";

contract KokoToken is BaseToken {
    
    string public constant name = "Koko";
    string public constant symbol = "KOK";
    uint8 public constant decimals = 18;
    
    uint private totalSupply = 0;
    
    function getTotalSupply() override external view returns (uint){
        return totalSupply;
    }
    
    
}
