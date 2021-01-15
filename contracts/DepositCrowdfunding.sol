// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;
import "@openzeppelin/contracts/math/SafeMath.sol";

/// @title Dapp de crowdfunding en Ether pour definir la structure et les fonctions de ce Smart Contract
/// @author Henri-Michel LEOCADIE
/// @notice Vous ne pouvez utliser ce contrat que pour faire des dépots et retour éventuel du ou des dépôts la plus basique
/// @dev Tous les appels de fonction sont implémentés sans effects secondaires

contract DepositCrowdfunding {
    using SafeMath for uint256;

    mapping(address => uint256) private _balances;
/// Fonction pour dépôt d'Ether avec sa balance
    function deposit() public payable {
        _balances[msg.sender] = _balances[msg.sender].add(msg.value);
    }

    function balanceOf(address addr) public view returns (uint256) {
        return _balances[addr];
    }

/// Fonction de transfert d'Ether avec sa balance
    function transfer(address dst, uint256 amount) public {
        require(_balances[msg.sender] >= amount, "DepositCrowdfunding: Not enough funds for transfer");
        _balances[dst] = _balances[dst].add(amount);
        _balances[msg.sender] = _balances[msg.sender].sub(amount);
    }

/// Fonction de récupération de l'Ether avec sa balance
    function withdraw(uint _amount, address payable _to) public {
        require(_balances[msg.sender] > 0, "DepositCrowdfunding: 0 ethers in wallet");

         _balances[msg.sender] = _balances[msg.sender].sub(_amount);

    
 /// Appel de la récupération de l'Ether dans sa balance   
        (bool success, ) = _to.call{value: _amount}(""); 
        require(success,"failed to transfer the funds");
    }
}
