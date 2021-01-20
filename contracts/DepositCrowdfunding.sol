// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;
pragma experimental ABIEncoderV2; // contract address :"0x22bF4B689F63ED71F701Ce59713D87fE0fd795b7"

import "@openzeppelin/contracts/math/SafeMath.sol";

/// @title Dapp de crowdfunding en Ether pour definir la structure et les fonctions de ce Smart Contract
/// @author Henri-Michel LEOCADIE
/// @notice Vous ne pouvez utliser ce contrat que pour faire des dépots et retour éventuel du ou des dépôts la plus basique
/// @dev Tous les appels de fonction sont implémentés sans effects secondaires


contract DepositCrowdfunding {
    
    using SafeMath for uint256;
    
 mapping(address => uint256) public balances;

    event Deposit(address sender, uint256 amount);
    event Withdrawal(address receiver, uint256 amount);
    event Transfer(address sender, address receiver, uint256 amount);

 function deposit() public payable {
        emit Deposit(msg.sender, msg.value);
        balances[msg.sender] = balances[msg.sender].add(msg.value);
    }

    function withdraw(uint256 amount) public { 
        require(balances[msg.sender] >= amount, "Insufficient funds");
        balances[msg.sender] = balances[msg.sender].sub(amount);
        emit Withdrawal(msg.sender, amount);
        msg.sender.transfer(amount);
    }

    function transfer(address receiver, uint256 amount) public { // SafeMath 
        require(balances[msg.sender] >= amount, "Insufficient funds");
        balances[msg.sender] = balances[msg.sender].sub(amount);
        balances[receiver] = balances[receiver].add(amount);
        emit Transfer(msg.sender, receiver, amount);
    }

        // Développement futur 
    /*function transfer(address[] memory receivers, uint amount) public {
        require(balances[msg.sender] >= receivers.length * amount, "Insufficient funds");
        for (uint i=0; i<receivers.length; i++) {
            balances[msg.sender] -= amount; //laisser SafeMath faire son travaille 
            balances[receivers[i]] += amount; //laisser SafeMath faire son travaille
             emit Transfer(msg.sender, receivers[i], amount);*
        }
    }*/
}
