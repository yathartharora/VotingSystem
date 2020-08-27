pragma experimental ABIEncoderV2;
pragma solidity ^0.6.0;
import "./RegisterAsVoter.sol";

contract Voting{
    
    RegisterAsVoter globals;
    // struct Voter{
    //     string FirstName;
    //     string LastName;
    //     string AadharCardNumber;
    //     uint Age;
    //     string MobileNumber;
    // }
    
    struct Candidate{
        string FirstName;
        string LastName;
        string AadharCardNumber;
        uint Age;
        string MobileNumber;
        uint VotesApproved;
    }
    
    //Voter[] public voters;
    Candidate[] public candidates;
    address public manager;
    mapping(address => bool) registeredascandidate;
    mapping(address => bool) voted;
    
    
    modifier restricted()
    {
        require(msg.sender==manager);
        _;
    }
    
    constructor (address _addr) public{
        manager = msg.sender;
        globals = RegisterAsVoter(_addr);
    }
    
    // function registerAsVoter(string memory firstname,string memory lastname,string memory Aadharnumber,uint age,string memory mobilenumber) public{
    //     Voter memory newVoter = Voter({
    //         FirstName: firstname,
    //         LastName: lastname,
    //         AadharCardNumber: Aadharnumber,
    //         Age: age,
    //         MobileNumber: mobilenumber
    //     });
        
    //     voters.push(newVoter);
    //     registeredasvoter[msg.sender] = true;
    // }
    
    function registerAsCandidate(string memory firstname,string memory lastname,string memory Aadharnumber,uint age,string memory mobilenumber) public{
        Candidate memory newCandidate = Candidate({
            FirstName: firstname,
            LastName: lastname,
            AadharCardNumber: Aadharnumber,
            Age: age,
            MobileNumber: mobilenumber,
            VotesApproved: 0
        });
        candidates.push(newCandidate);
    }
    
    function Vote(uint index) public{
        require(globals.registeredasvoter(msg.sender));
        require(!voted[msg.sender]);
        candidates[index].VotesApproved++;
        voted[msg.sender] = true;
    }
    
    
    
}
