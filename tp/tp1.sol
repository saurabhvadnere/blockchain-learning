// SPDX-License-Identifier: MIT
pragma solidity  ^0.8.0;

contract Num {

uint [] public Numbers = [5,5,6,8,2,7,9,6,5,2,32,6,46,8];

function getNumber(uint index) public view returns (uint) {
   return Numbers[index-1];
}

function get_total_arrays() public view returns (uint [] memory){
    return Numbers;
}

function get_lenght() public view returns (uint){
    return Numbers.length;
}

function removelast() public {
    return Numbers.pop();
}

function add(uint a) public {
    return Numbers.push(a);
}

function sumArray() public view returns (uint) {
    uint sum = 0;

    for(uint i = 0; i < Numbers.length; i++){
        sum += Numbers[i];
    }

    return sum;
}

}