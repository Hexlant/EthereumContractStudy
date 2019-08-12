pragma solidity ^0.5.0;

contract Token_Model{
    string public name="MyToken";
    string public symbol="MTK";
    uint8 public decimals=18;
    uint256 public totalSupply;
    

    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowed;
    
    function getBalance(address _owner) public view returns(uint256) {
        return _balances[_owner];
    }
    
    function setBalance(address _owner, uint256 value) public returns(bool) {
        _balances[_owner] = value;
        return true;
    }
    
    function getAllowed(address _owner, address _spender) public view returns(uint256) {
        return _allowed[_owner][_spender];
    }
    
    function setAllowed(address _owner, address _spender, uint256 value) public returns(bool) {
        _allowed[_owner][_spender] = value;
        return true;
    }
    
    function setTotalSupply(uint256 value) public returns(bool) {
        totalSupply=value;
    }
}