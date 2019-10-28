pragma solidity ^0.5.0;


contract Callee {
    address public caller;
    event Called(address indexed);
    event WhoAmI(address indexed);
    
    constructor() public {
    }
    
    function func() public returns (bool result){
        caller = msg.sender;
        emit Called(caller);
        emit WhoAmI(address(this));
        result = true;
    }
}

contract Caller {
    Callee public _callee;
    constructor(address _ca) public {
        _callee = Callee(_ca);
    }
    
    function funcDefaultCall() public returns (bool result){
        result = _callee.func();
    }
    
    function funcStaticCall() public returns (bool){
        (bool result,) = address(_callee).call(abi.encodePacked(bytes4(keccak256("func()"))));
        return result;

    }
    
    function funcDelegateCall() public returns (bool ){
        (bool result,) = address(_callee).delegatecall(abi.encodePacked(bytes4(keccak256("func()"))));
        return result;
    }
    
    
}
