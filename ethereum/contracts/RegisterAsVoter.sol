// SPDX-License-Identifier: MIT
pragma experimental ABIEncoderV2;
pragma solidity ^0.4.25;

contract RegisterAsVoter{
    struct Voter{
        string FirstName;
        string LastName;
        uint Age;
        string MobileNumber;
    }
    
    Voter[] public voters;
    mapping(address => bool) public registeredasvoter;
    
    function registerAsVoter(string firstname,string lastname,uint age,string mobilenumber) public{
        
        require(!registeredasvoter[msg.sender]);
        Voter memory newVoter = Voter({
            FirstName: firstname,
            LastName: lastname,
            Age: age,
            MobileNumber: mobilenumber
        });
        
        require(age>18);
        voters.push(newVoter);
        registeredasvoter[msg.sender] = true;
    }
}
