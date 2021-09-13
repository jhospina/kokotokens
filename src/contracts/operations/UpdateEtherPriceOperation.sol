// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "../../libs/interfaces/IExternalAPI.sol";
import "../../libs/interfaces/SuccessRequestListener.sol";
import "../../libs/StringUtils.sol";

contract UpdateEtherPriceOperation is SuccessRequestListener {
    
    using StringUtils for string;
    uint etherPrice;
    
    IExternalAPI externalAPI;
    
    constructor(IExternalAPI _externalAPI) {
       externalAPI = _externalAPI;    
       externalAPI.setOnSuccessListener(this);
    }
    
    function onSuccess(string memory result) external override {
      require(address(this) == msg.sender, "This function must be call only by own contract");
      // Se parsea los datos del resultado con 2 decimales
      etherPrice=result.parseInt(2);
    }
    
    function updatePrice() external payable {
        externalAPI.requestUrl("https://api.kraken.com/0/public/Ticker?pair=ETHUSD","result.XETHZUSD.c.0");
    }
    
    function getEtherPrice() external view returns(uint) {
        return etherPrice;
    }
}
