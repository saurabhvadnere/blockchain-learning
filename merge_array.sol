// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract MergeElements {

    event allarray(address indexed user, uint [] array);

    uint[] public array1 = [20,11,45,74,88,12];
    uint[] public array2 = [21,52,12,4,19,11];

    uint[] array3;

    function mergeall() public {

        for (uint i = 0; i < array1.length; i++) {
            array3.push(array1[i]);
        }

        for (uint j = 0; j < array2.length; j++) {
            array3.push(array2[j]);
        }           
    }
        
    function getAll () public view returns (uint [] memory){
        return array3;

        emit allarray(msg.sender, getAll);
    }
}
