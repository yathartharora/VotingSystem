pragma experimental ABIEncoderV2;
pragma solidity ^0.6.0;

contract Voting{
    
    
    struct Voter{
        string FirstName;
        string LastName;
        string AadharCardNumber;
        uint Age;
        string MobileNumber;
    }
    
    Voter[] public voters;
    address public manager;
    
    constructor () public{
        manager = msg.sender;
    }
    
    function register(string memory firstname,string memory lastname,string memory Aadharnumber,uint age,string memory mobilenumber) public{
        Voter memory newVoter = Voter({
            FirstName: firstname,
            LastName: lastname,
            AadharCardNumber: Aadharnumber,
            Age: age,
            MobileNumber: mobilenumber
        });
        
        voters.push(newVoter);
    }
    
    function display(uint index) public view returns(string memory, string memory){
        return (
            voters[index].FirstName,
            voters[index].LastName
            );
    }
    
}
