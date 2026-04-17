// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Inumber {
        function num() external view returns (uint);
    }

contract second {

Inumber ns;
    constructor (address contract_address){
        ns = Inumber(contract_address);
    }

    // function read_val (address valaddress) public view returns (uint){
    //     Inumber ns = Inumber(valaddress);
    //     return ns.num();
    // }
    function real_val () public view returns (uint){
       return ns.num();
    }

    
}