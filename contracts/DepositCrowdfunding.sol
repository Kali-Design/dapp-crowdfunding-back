// address abi : "0xcDf4C8AC61eE80c55367CE347742766a6Ea3C0D2"
// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

/// @title Dapp de crowdfunding en Ether pour definir le champ de ce Smart Contract
/// @author Henri-Michel LEOCADIE
/// @notice Vous ne pouvez utliser ce contrat que pour faire des dépots et retour éventuel
/// @dev Tous les appels de fonction sont implémentés sans effects secondaires     
   
// Defining a Contract 
contract DepositCrowdfunding{ 
  
    // Déclaration des variables d'état
    address payable public buyer; 
    address payable public seller; 
    address payable public arbiter; 
    mapping(address => uint) TotalAmount; 
  
    // Définition d'un énumérateur 'État'
    enum State{ 
         
        // Voici les données membres
        awate_payment, awate_delivery, complete  
    } 
  
    // Déclaration de l'objet de l'énumérateur
    State public state; 
      
    // Définition du modificateur de fonction 'instate' 
    modifier instate(State expected_state){ 
          
        require(state == expected_state); 
        _; 
    } 
  
   // Définition du modificateur de fonction 'OnlyBuyer'
    modifier onlyBuyer(){ 
        require(msg.sender == buyer ||  
                msg.sender == arbiter); 
        _; 
    } 
  
    // Défintion du modificateur de fonction 'OnlySeller'
    modifier onlySeller(){ 
        require(msg.sender == seller); 
        _; 
    } 
      
    // Défintion du constructeur
    constructor(address payable _buyer,  
                address payable _sender) public{ 
        
        // Assignation des valeurs 
        // Variables d'état
        arbiter = msg.sender; 
        buyer = _buyer; 
        seller = _sender; 
        state = State.awate_payment; 
    } 
      
    /// Définition de la fonction pour confirmer le paiement
    /// @dev Permet de confirme le paiement
    function confirm_payment() onlyBuyer instate( 
      State.awate_payment) public payable{ 
      
        state = State.awate_delivery; 
          
    } 
      
    /// Définition de la fonction pour confirmer la transaction
    /// @dev Permet de confirmer le statut du paiement et sa balance
    function confirm_Delivery() onlyBuyer instate( 
      State.awate_delivery) public{ 
          
        seller.transfer(address(this).balance); 
        state = State.complete; 
    } 
  
    /// Définition de la fonction pour retourner le paiement
    /// @dev Permet de récuperer son paiement et retourner dans sa balance
    function ReturnPayment() onlySeller instate( 
      State.awate_delivery)public{ 
        
         
       buyer.transfer(address(this).balance); 
    } 
      
} 
