// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Math {
    function test (uint x) internal pure returns (string memory) {
        if (x % 2 == 0)
            return "Even Number";
        else 
        return "OddNumber";

        // return  x%2 ==0 ? "Even Number" : "OddNumber" ;
    }
}    

contract check_number is Math {
    
    function even_or_odd ( uint y) public pure returns (string memory){
        return Math.test(y);
    }
}
