pragma solidity ^0.4.25;

contract Hello {
    address public creator;
    uint256 public num;
    
    event Hi(string,address);
    constructor() public {
        creator = msg.sender;
        emit Hi("Create!",0);
    }
    
    function hi() public returns (uint256){
        emit Hi("loop!",0);
        return 100;
    }
    
    function constantF() external view returns(uint256) {
        return num+1;
    }
    
    function constantLoop() external pure returns(uint256) {
        uint256 n = 0;
        while(true){
            n +=1;
        }
        return n;
    }
    
    
}