// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./interfaces/IExternalAPI.sol";
import "./interfaces/SuccessRequestListener.sol";

uint256 constant CUSTOM_GASLIMIT = 150000;

abstract contract ExternalAPI is IExternalAPI {

    SuccessRequestListener listener;

    function setOnSuccessListener(SuccessRequestListener _listener) external override{
        listener = _listener;
    }

    mapping(bytes32=>bool) internal idQueries;

    function requestUrl(string memory endpoint, string memory pathData) external override payable {
        uint gasRequired = provable_getPrice("URL", CUSTOM_GASLIMIT);
        uint currentBalance = address(this).balance;
        // Valida el limite del gas asignado
        require(gasRequired <= currentBalance, string(abi.encodePacked("The Gas limit is so hight! Your current balance is ", uint2str(currentBalance), " and you need ", uint2str(gasRequired))));
        // Realiza la peticion a la URL indicada con el path de data indicado
        bytes32 queryId = provable_query("URL", string(abi.encodePacked("json(", endpoint, ").", pathData)));
        // Registra el ID de la consulta
        idQueries[queryId] = true;
    }

    function __callback(bytes32 queryId, string memory result) override public {
        // Valida el ID de la consulta con el ID de la consulta realizado
        require(idQueries[queryId], "Id query is not valid!");
        // Valida que la direccion de la respuesta venga del contrato
        require(msg.sender == provable_cbAddress(), "address request is not valid!");
        // Ejecuta el callback con el resultado de la respuesta
        listener.onSuccess(result);
        // Elimina el ID de la consulta ya realizada
        delete idQueries[queryId];
    }

    function _getContractAddress() external override returns (address){
        return address(this);
    }

}