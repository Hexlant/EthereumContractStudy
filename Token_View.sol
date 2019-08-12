pragma solidity ^0.5.0;
import './Token_Control.sol';

contract Token_View {
    Token_Control control;
    
    function setcontrol(Token_Control _control) public returns(bool) {
        control = _control;
        return true;
    }

    constructor() public {
    }
    
    function name() public view returns (string memory) {
        return control.name();
    }
    
    function symbol() public view returns (string memory) {
        return control.symbol();
    }
    
    function decimals() public view returns (uint8) {
        return control.decimals();
    }
    
    function totalSupply() public view returns (uint256) {
        return control.totalSupply();
    }
    
    function balanceOf(address _owner) public view returns (uint256 balance) {
        return control.balanceOf(_owner); 
    }
    
    function transfer(address _to, uint256 _value) public returns (bool success) {
        control.transfer(msg.sender, _to, _value);
        return true;
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        return control.transferFrom(msg.sender, _from, _to, _value);
    }
    
    function approve(address _spender, uint256 _value) public returns (bool success) {
        return control.approve(msg.sender, _spender, _value);
    }
    
    function allowance(address _owner, address _spender) public view returns (uint256 remaining){
        return control.allowance(_owner, _spender);
    }
    
    function init() public returns(bool)
    {
        control.mint(msg.sender, 100000000 * 10 ** 18);
        return true;
    }


}