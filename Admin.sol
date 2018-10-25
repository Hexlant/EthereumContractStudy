pragma solidity ^0.4.25;

contract Admin {
    address public admin;
    constructor() public{
        admin = msg.sender;
    }
    
    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }
    
    function transferRoles (address _newOwner) public returns(bool) {
        require(_newOwner != address(0));
        admin = _newOwner;
    }
    
}