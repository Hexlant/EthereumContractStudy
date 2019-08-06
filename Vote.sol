pragma solidity ^0.5.0;

contract Vote {
    
    mapping (bytes32 => uint256) public subject;
    mapping (address => bool) public voter;
    string[] public subjectList;
    uint256 public subjectCount;
    
    uint256 public voteCount;
    
    event Vote(address, string);
    
    struct votelog {
        address voter;
        string subject;
    }
    
    function vote(string memory _subject) public {
        require(voter[msg.sender] == false);
        bytes32 hash = keccak256(bytes(_subject));
        
        if(subject[hash] == 0) {
            subjectList.push(_subject);
            subjectCount = subjectCount+1;
        }
        subject[hash] = subject[hash] + 1;
        
        voter[msg.sender] = true;
        emit Vote(msg.sender, _subject);
        voteCount = voteCount +1;
    }
    
    function voteCountOf(string memory _subject) public view returns(uint256) {
         bytes32 hash = keccak256(bytes(_subject));
         return subject[hash];
    }
  
    function getSubjecttoHash(string memory _subject) public view returns(bytes32){
        return keccak256(bytes(_subject));
    }
}
