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
    uint256 Amount;
    address Addr;
    
    mapping(address => uint256) private _balances;

    function deposit() public payable {
        _balances[msg.sender] = _balances[msg.sender].add(msg.value);
    }

    function balanceOf(address addr) public view returns (uint256) {
        return _balances[addr];
    }

    
    /*function transfer(address dst, uint256 amount) public {
        require(_balances[msg.sender] >= amount, "DepositCrowdfunding: Not enough funds for transfer");
        Amount = amount;
        _balances[dst] = _balances[dst].add(amount);
        _balances[msg.sender] = _balances[msg.sender].sub(amount);
        
    }*/
    
    function transfer(address _recipient, uint256 _amount) public returns (bool) {
        require(_balances[msg.sender] >= _amount, 'transfer amount exceeds balance');
        _balances[msg.sender] = _balances[msg.sender].sub(_amount);
        _balances[_recipient] = _balances[_recipient].add(_amount);
        emit Transfer(msg.sender, _recipient, _amount);
        return true;

    }

    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    
    function withdraw(address addr, uint _amount, address payable _to) public {
        require(_balances[msg.sender] > 0, "DepositCrowdfunding: 0 ethers in wallet");
        Addr = addr;
         _balances[msg.sender] = _balances[msg.sender].sub(_amount);

        
        //_balances[msg.sender] = 0;
    
        (bool success, ) = _to.call{value: _amount}(""); 
        require(success,"failed to transfer the funds");
    }
    
    function getAmount() public view returns (uint256) {
        return Amount;
    }
    
    
}
