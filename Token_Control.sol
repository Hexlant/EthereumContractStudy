pragma solidity ^0.5.0;
import './Token_Model.sol';
import './SafeMath.sol';

contract Token_Control{
    using SafeMath for uint256;
    Token_Model model;
    
    event Transfer(address indexed _from, address indexed _to, uint256 _value);
    event Approval(address indexed _owner, address indexed _spender, uint256 _value);
    
    function setModel(Token_Model _model) public returns(bool) {
        model = _model;
    }
    
    function name() public view returns (string memory) {
        return model.name();
    }
    
    function symbol() public view returns (string memory) {
        return model.symbol();
    }
    
    function decimals() public view returns (uint8) {
        return model.decimals();
    }
    
    function totalSupply() public view returns (uint256) {
        return model.totalSupply();
    }
    
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return model.getBalance(_owner); 
    }
    
    function transfer(address _from, address _to, uint256 value) public returns(bool){
        require(value <= model.getBalance(_from));
        require(_to != address(0));
        _transfer(_from, _to, value);
        return true;
    }
    
    function _transfer(address from, address to, uint256 value) internal {
        //_balances[from] = _balances[from].sub(value);
        model.setBalance(from,
            model.getBalance(from).sub(value) 
        );
        
        //_balances[to] = _balances[to].add(value);
        model.setBalance(to,
            model.getBalance(to).add(value) 
        );
        emit Transfer(from, to, value);
    }
  
    function transferFrom(address spender, address from, address to, uint256 value ) public returns(bool){
        require(value <= model.getAllowed(from, spender));
        model.setAllowed( from, spender,
            model.getAllowed(from, spender).sub(value)
        );
        //_allowed[from][msg.sender] = _allowed[from][msg.sender].sub(value);
        _transfer(from, to, value);
        return true;
    }
    
    function mint(address to, uint256 value) public returns (bool) {
        require(to != address(0));
        model.setTotalSupply(
            model.totalSupply().add(value)
        );
        model.setBalance(to,
            model.getBalance(to).add(value) 
        );
        emit Transfer(address(0), to, value);
        return true;
    }
    
    function approve(address _owner, address _spender, uint256 _value) public returns (bool success) {
        return model.setAllowed(_owner, _spender, _value);
    }
    
    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return model.getAllowed(_owner, _spender);
    }
}