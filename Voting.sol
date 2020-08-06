pragma solidity ^0.4.17;

contract Voting {
    
    struct Candidate {
        string name;
        string scholarnumber;
        uint votes;
    }
    
    Candidate[] public candidates;
    address public manager;
    mapping(address=>bool) voter;
    mapping(address=>bool) registered;
    uint totalVotes; 
    
    
    modifier restricted() {
        require(msg.sender==manager);
        _;
    }
    
    constructor () public {
        manager = msg.sender;
    }
    
    function registerToVote() public {
        registered[msg.sender] = true;
        voter[msg.sender] = false;
    }
    
    function registerAsCandidate(string n,string s) public restricted{
        Candidate memory newCandidate = Candidate({
            name: n,
            scholarnumber: s,
            votes: 0
        });
        candidates.push(newCandidate);
    }
    
    
    function vote(uint index) public{
       require(registered[msg.sender]);
       require(!voter[msg.sender]);
       
       totalVotes++;
       voter[msg.sender] = true;
       candidates[index].votes++;
    }
    
}