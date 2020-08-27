pragma experimental ABIEncoderV2;
pragma solidity ^0.6.0;
import "./RegisterAsVoter.sol";


contract Factory{
    
    Voting[] public deployedContracts;
    
    function createContract() public {
        Voting newContract = new Voting(msg.sender);
        deployedContracts.push(newContract);
    }
    
    function getDeployedContracts() public view returns(Voting[] memory){
        return deployedContracts;
        
    }
}

contract Voting{
    
    RegisterAsVoter globals;
    struct Candidate{
        string FirstName;
        string LastName;
        string AadharCardNumber;
        uint Age;
        string MobileNumber;
        uint VotesApproved;
    }
    
    Candidate[] public candidates;
    address public manager;
    mapping(address => bool) registeredascandidate;
    mapping(address => bool) voted;
    
    
    modifier restricted()
    {
        require(msg.sender==manager);
        _;
    }
    
    constructor (address sender) public{
        manager = sender;
        globals = RegisterAsVoter(0xBe804c172E9e046a9652f6f55Bbb9230c00DA097);
    }
    
    
    function registerAsCandidate(string memory firstname,string memory lastname,string memory Aadharnumber,uint age,string memory mobilenumber) public{
        require(!registeredascandidate[msg.sender]);
        Candidate memory newCandidate = Candidate({
            FirstName: firstname,
            LastName: lastname,
            AadharCardNumber: Aadharnumber,
            Age: age,
            MobileNumber: mobilenumber,
            VotesApproved: 0
        });
        candidates.push(newCandidate);
        registeredascandidate[msg.sender] = true;
    }
    
    function Vote(uint index) public{
        require(globals.registeredasvoter(msg.sender));
        require(!voted[msg.sender]);
        candidates[index].VotesApproved++;
        voted[msg.sender] = true;
    }
    
    
}
