pragma solidity ^0.4.25;

contract ConstantTest {
    uint256 public counter;
    
    event Counter(uint256);
    constructor() public {
        
    }
    
    function func() public {
        uint256 number = constantFunc();
        counter = number;
        emit Counter(counter);
    }
    
    function constantFunc() public view returns(uint256) {
        uint256 sum=0;
        for(uint8 i=0; i<10;i++){
            sum = sum + i;
        }
        return counter+sum;
    }
    
    
    
}