// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.4.25;
import "./RegisterAsVoter.sol";

contract Voting{
    
    RegisterAsVoter global;
    struct RegisterAsCandidate{
        string firstname;
        string lastname;
        string mobilenumber;
        bytes4 votingid;
        string about;
    }
    
    RegisterAsCandidate[] public candidates; 
    mapping (address => bool) public registeredcandidates;
    mapping(bytes4 => bool) public usedVotingId;
    mapping(address => bool) public voted;
    mapping(bytes4 => uint) public vote;
    address manager;
    
    constructor() public {
        manager = msg.sender;
        global = RegisterAsVoter(0x6a4583868847e0b8B00E367293F5A5443Db8a09c);
    }
    
    function Register(string fname,string lname,string mnumber,bytes4 phrase,string about) public {
        
        require(global.registeredasvoter(msg.sender));
        require(!registeredcandidates[msg.sender]);
        require(!usedVotingId[phrase]);
        
        RegisterAsCandidate memory newCandidate = RegisterAsCandidate({
            firstname: fname,
            lastname: lname,
            mobilenumber: mnumber,
            votingid: phrase,
            about: about
        });
        
        vote[phrase] = 0;
        candidates.push(newCandidate);
        registeredcandidates[msg.sender] = true;
        usedVotingId[phrase] = true;
    }
    
    function Vote(bytes4 hashvalue) public {
        
        //Ensure that the voter has registered
        require(global.registeredasvoter(msg.sender));
        
        //The voter has not already voted
        require(!voted[msg.sender]); 
        
        //The person for whom the voter is voting is valid
        require(usedVotingId[hashvalue]);
        
        //Increment the Votecount
        vote[hashvalue]+=1;
        
        voted[msg.sender] = true;
    } 
    
    
}
