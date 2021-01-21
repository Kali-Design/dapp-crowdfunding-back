// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0; // Langue de compilation
pragma experimental ABIEncoderV2; // Encoder pour éviter les bugs dans la Blockchain

import "@openzeppelin/contracts/math/SafeMath.sol"; // Librairie Openzepplin de sécurisation échanges d'argents numériques

/// @title Dapp de crowdfunding en Ether pour definir la structure et les fonctions de ce Smart Contract
/// @author Henri-Michel LEOCADIE
/// @notice Vous ne pouvez utliser ce contrat que pour faire des dépots et retour éventuel du ou des dépôts la plus basique
/// @dev Tous les appels de fonction sont implémentés sans effects secondaires


contract DepositCrowdfunding {

/// @info code : SafeMath librairie d'Openzepplin qui sécurise tous les échanges d'argents numériques 
/// dans le Blockchain   
    using SafeMath for uint256;

/// @info code : "mapping" est une variable qui permet d'associer deux variables entre elles,
/// cependant ici, elle gére les adresses et les montants

 mapping(address => uint256) public balances;

/// @info code : "Event" pour la gestion des montants versés lors du Deposit, le Withdraw et le transfert ainsi
/// qu'un call pour rappeller l'adresse ou les adresses avec leurs montants.

    event Deposit(address sender, uint256 amount);
    event Withdrawal(address receiver, uint256 amount);
    event Transfer(address sender, address receiver, uint256 amount);

 /// @info code : le .add utilise bien la sécurité du SafeMath de la bibliothéque d'Openzepplin
 /// @info code : la fonction "deposit" est pour déposer de l'Ether dans le contrat déployer avec sa balance

 function deposit() public payable {
        emit Deposit(msg.sender, msg.value);
        balances[msg.sender] = balances[msg.sender].add(msg.value);
    }
/// @info code : la fonction "withdraw" est pour rembourser simplement à partir du Front
/// @info code : le "require" est pour vérifier que l'argent est bien sur le compte avant le remboursement
/// @info code : "Emit" fait un appel à "Event Withdrawal" et sa envoi à l'adresse du "receiver" un montant, ensuite la 
/// balance de celui qui envoie l'argent soustraire le montant puis l'envoi au "receiver"

    function withdraw(uint256 amount) public { 
        require(balances[msg.sender] >= amount, "Insufficient funds");
        balances[msg.sender] = balances[msg.sender].sub(amount);
        emit Withdrawal(msg.sender, amount);
        msg.sender.transfer(amount);
    }
/// @info code : le .sub et le .add utilise bien la sécurité du SafeMath de la bibliothéque d'Openzepplin
/// @info code : La fonction "transfer" permet d'envoyer de l'argent sur un autre compte en superAdmin pour rembourser
/// de manière indépendante et dispatcher sur différentes comptes

    function transfer(address receiver, uint256 amount) public { 
        require(balances[msg.sender] >= amount, "Insufficient funds");
        balances[msg.sender] = balances[msg.sender].sub(amount);
        balances[receiver] = balances[receiver].add(amount);
        emit Transfer(msg.sender, receiver, amount);
    }

/// @ info code : Développement futur de la dapp pour intégrer et mémoriser plusieurs adresses en même temps dans le Front
    /*function transfer(address[] memory receivers, uint amount) public {
        require(balances[msg.sender] >= receivers.length * amount, "Insufficient funds");
        for (uint i=0; i<receivers.length; i++) {
            balances[msg.sender] -= amount; 
            balances[receivers[i]] += amount; 
             emit Transfer(msg.sender, receivers[i], amount);*
        }
    }*/
}
