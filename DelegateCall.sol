pragma solidity ^0.4.22;


contract Callee {
    address public caller;
    
    event Called(address indexed);
    
    constructor() public {
    }
    
    function func() public returns (bool result){
        caller = msg.sender;
        emit Called(caller);
        result = true;
    }
    
    
}

contract Caller {
    Callee public _callee;
    constructor(address _ca) public {
        _callee = Callee(_ca);
    }
    
    function func1() public returns (bool result){
        result = _callee.func();
    }
    
    function func2() public returns (bool result){
        result = address(_callee).call(bytes4(keccak256("func()")));
    }
    
    function func3() public returns (bool result){
        result = address(_callee).delegatecall(bytes4(keccak256("func()")));
    }
    
    
}
