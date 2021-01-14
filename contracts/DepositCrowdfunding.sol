// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/// address du Smart Contract depuis migration : "0xcDf4C8AC61eE80c55367CE347742766a6Ea3C0D2"

/// @title Dapp de crowdfunding en Ether pour definir la structure et les fonctions de ce Smart Contract
/// @author Henri-Michel LEOCADIE
/// @notice Vous ne pouvez utliser ce contrat que pour faire des dépots et retour éventuel du ou des dépôts la plus basique
/// @dev Tous les appels de fonction sont implémentés sans effects secondaires

contract DepositCrowdfunding {

    address payable private _superAdmin; // Adresse de la personne qui déploie

/// Vérification super admin
    modifier isSuperAdmin() {
        require(msg.sender == _superAdmin, "Vous n'avez pas le droit d'utiliser cette fonction");
        _;
    }
 /// Structure de l'utilisateur
struct Deposit {
	string name; // Nom de l'utilisateur 
	string email; // Email de l'utilisateur
	uint value; // Le montant qui versera
	bool complete; // Toutes les informations sont vraies
	uint approvalCount; // Le montant de l'utilisateur est approuvé
	mapping(address => bool) approvals; // Toutes les adresses sont approuvées
	}
   
    address payable owner;
/// L'adresse du propriétaire 
    constructor(uint, address) public {
        owner = owner;
/// Constructeur comme variable d'état
   
     owner = msg.sender;
/// Le propriétaire = owner appelle le Smart Contract DepositCrowdfunding

    }
    
    function deposit() public payable {
/// Fonction pour déposer de l'Ether
        require(owner == msg.sender);
/// Fonction pour transférer de l'Ether 
        owner.transfer(address(this).balance);
    }
    
/// Structure pour récupérer son Ether
    struct Withdraw {
	string name;
	string email;
	uint value;

	}
    
    function withdraw() public payable {
// Seul le propriétaire sera exigé pour récupérer son Ether         
        require(owner == msg.sender);
// Fonction pour récupérer son Ether à partir de l'adresse de dépôt et vérifier sa balance
        owner.transfer(address(this).balance);
    }
    
    function withdraw(uint256 amount) public {
// Fonction pour récupérer son Ether et voir sa balance sur son compte du retour de son Ether
        require(owner == msg.sender);
        require(address(this).balance >= amount);
        
        owner.transfer(amount);
    }
    
  
}
