// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import "./interfaces/IExternalAPI.sol";

uint256 constant CUSTOM_GASLIMIT = 150000;

abstract contract ExternalAPI is IExternalAPI {
    
    mapping(bytes32=>bool) internal idQueries;

    function requestUrl(string memory endpoint, string memory pathData) external override payable {
        // Valida el limite del gas asignado
        require(provable_getPrice("URL", CUSTOM_GASLIMIT) < address(this).balance, "The Gas limit is so hight!");
        // Realiza la peticion a la URL indicada con el path de data indicado
        bytes32 queryId = provable_query("URL", string(abi.encodePacked("json(", endpoint, ")", pathData)));
        // Registra el ID de la consulta
        idQueries[queryId] = true;
    }
    
    function __callback(bytes32 queryId, string memory result) override public {
        // Valida el ID de la consulta con el ID de la consulta realizado
        require(idQueries[queryId], "Id query is not valid!");
        // Valida que la direccion de la respuesta venga del contrato 
        require(msg.sender == provable_cbAddress(), "address request is not valid!");
        // Ejecuta el callback con el resultado de la respuesta
        this.onSuccess(result);
        // Elimina el ID de la consulta ya realizada
        delete idQueries[queryId];
    }
}