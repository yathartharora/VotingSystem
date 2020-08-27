pragma experimental ABIEncoderV2;
pragma solidity ^0.6.0;

contract RegisterAsVoter{
    struct Voter{
        string FirstName;
        string LastName;
        string AadharCardNumber;
        uint Age;
        string MobileNumber;
    }
    
    Voter[] public voters;
    mapping(address => bool) public registeredasvoter;
    
    function registerAsVoter(string memory firstname,string memory lastname,string memory Aadharnumber,uint age,string memory mobilenumber) public{
        Voter memory newVoter = Voter({
            FirstName: firstname,
            LastName: lastname,
            AadharCardNumber: Aadharnumber,
            Age: age,
            MobileNumber: mobilenumber
        });
        
        voters.push(newVoter);
        registeredasvoter[msg.sender] = true;
    }
}
