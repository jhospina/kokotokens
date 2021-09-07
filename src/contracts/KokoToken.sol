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

    /**
    * @dev
    *
    * totalSupply: Almacena la cantidad total de tokens que en circulación dentro del ecosistema.
    * Los tokens pueden generarse y destruirse.
    *
    * */
    uint private totalSupply = 0;

    /**
    * @dev
    *
    * Define los propietarios y los delegados quienes tienen permiso de utilizar un monto asignado.
    * Ver Standard ERC-20 (https://eips.ethereum.org/EIPS/eip-20)
    *
    * Owner: Propietario de los tokens
    * Delegate: Quienes puede hacer uso de esos tokens en nombre del propietario.
    *
    * Delegate => [WalletOwner, WalletOwner,...]
    *
    * */
    mapping(address => mapping(address => uint)) allowedWallets;

    /**
    * @dev
    * Almacena todas cuentas que existen en el ecosistema.
    * */
    mapping(address => Wallet) wallets;

    /**
    * @dev
    *
    * Retorna el total de tokens que existe en el ecosistema
    *
    * @return uint
    * */
    function getTotalSupply() override external view returns (uint){
        return totalSupply;
    }

    /**
    * @dev
    *
    * Registra una nueva wallet con una cantidad de Zero(0) de tokens.
    * Quien realiza la transacción (sender) queda registrado como delegado de esta nueva wallet.
    *
    * */
    function addNewWallet(address _address) override external returns (bool) {
        // Crea una nueva wallet con la dirección indicada y un valor inicial de Zero tokens
        Wallet memory wallet = Wallet(_address, INT_MIN);
        // Valida que la wallet no se cuentre registrada.
        require(wallets[_address]._address!=_address, "Wallet address already exists");
        // Agrega la nueva wallet
        wallets[_address] = wallet;
        // Habilita al sender para usar la nueva wallet
        allowedWallets[msg.sender][_address] = INT_MIN;
        return true;
    }

    function increaseWalletBalanceSender(uint amount) override external {

        uint currentBalance = wallets[msg.sender].balance;

        wallets[msg.sender].balance = currentBalance.sum(amount);
        increaseTotalSupply(amount);
    }

    function increaseTotalSupply(uint amount) private {
        totalSupply = totalSupply.sum(amount);
    }

    function decreaseTotalSupply(uint amount) private {
        totalSupply = totalSupply.subtract(amount);
    }
}
