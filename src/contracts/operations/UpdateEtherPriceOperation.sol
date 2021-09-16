// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "../../libs/interfaces/IExternalAPI.sol";
import "../../libs/interfaces/SuccessRequestListener.sol";
import "../../libs/StringUtils.sol";

// Indica el tiempo de frecuencia en el que se debe actualizar el precio
uint constant FREQUENCY_UPDATE_PRICE = 60 * 30; // 30 minutos

contract UpdateEtherPriceOperation is SuccessRequestListener {

    using StringUtils for string;

    // Almacena el ultimo precio del ethereum en USD de forma int. (Ex: 345060 => 3450.60)
    uint etherPrice;
    // Almacena la fecha y hora de la ultima actualizacion
    uint lastUpdated = 0;
    // Dependencias
    IExternalAPI externalAPI;

    constructor(IExternalAPI _externalAPI) {
        externalAPI = _externalAPI;
        externalAPI.setOnSuccessListener(this);
    }

    function onSuccess(string memory result) external override {
        require(externalAPI._getContractAddress() == msg.sender, "This function must be call only by own contract");
        // Se parsea los datos del resultado con 2 decimales
        etherPrice = result.parseInt(2);
        lastUpdated = externalAPI._getCurrentTimestamp();
    }

    function updatePrice() external payable returns (bool) {
        // Valida que el momento actual sea el momento de actualizar el precio
        if (!this.isReadyToUpdatePrice()) {
            return false;
        }
        externalAPI.requestUrl("https://api.kraken.com/0/public/Ticker?pair=ETHUSD", "result.XETHZUSD.c.0");
        return true;
    }

    function isReadyToUpdatePrice() external returns (bool){
        // Calcula el momento siguiente en que se debe actualizar el precio
        uint nextTimeUpdate = lastUpdated + FREQUENCY_UPDATE_PRICE;
        return externalAPI._getCurrentTimestamp() >= nextTimeUpdate;
    }

    function getEtherPrice() external view returns (uint) {
        return etherPrice;
    }

}
