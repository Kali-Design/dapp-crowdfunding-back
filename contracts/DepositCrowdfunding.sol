// SPDX-License-Identifier: MIT
pragma solidity >=0.6.0 <0.8.0;
import "@openzeppelin/contracts/math/SafeMath.sol";

contract DepositCrowdfunding {
    using SafeMath for uint256;

    mapping(address => uint256) private _balances;

    function deposit() public payable {
        _balances[msg.sender] = _balances[msg.sender].add(msg.value);
    }

    function balanceOf(address addr) public view returns (uint256) {
        return _balances[addr];
    }

    
    function transfer(address dst, uint256 amount) public {
        require(_balances[msg.sender] >= amount, "DepositCrowdfunding: Not enough funds for transfer");
        _balances[dst] = _balances[dst].add(amount);
        _balances[msg.sender] = _balances[msg.sender].sub(amount);
    }

    // 
    function withdraw(uint _amount, address payable _to) public {
        require(_balances[msg.sender] > 0, "DepositCrowdfunding: 0 ethers in wallet");

         _balances[msg.sender] = _balances[msg.sender].sub(_amount);

        
        //_balances[msg.sender] = 0;
    
        (bool success, ) = _to.call{value: _amount}(""); 
        require(success,"failed to transfer the funds");
    }
}
