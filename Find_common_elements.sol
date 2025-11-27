// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract FindCommonElements {

    uint[] public array1 = [20,11,45,74,88,12];
    uint[] public array2 = [21,52,12,4,19,11];

    uint[] public common;

    function findCommon() public {
        delete common; // clear old results

        for (uint i = 0; i < array1.length; i++) {
            for (uint j = 0; j < array2.length; j++) {

                // If element from array1 matches array2 element
                if (array1[i] == array2[j]) {

                    // Add it to result array
                    common.push(array1[i]);

                    // Stop checking further for this i (optional optimization)
                    break;
                }
            }
        }
    }
    
    function getAll_common () public view returns (uint [] memory){
        return common;
    }
}
