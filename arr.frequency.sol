// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract freq_array{
    uint [] public arr=[10,20,30,40,50];
    uint public l=0;
    uint public g=0;
    uint public e=0;

    function freq(uint val) public {
        for (uint i=0;i<arr.length;i++)
    {
        if(arr[i]>val) g++;
        else if (arr[i]<val) l++;
        else e++;
    }
    }
    function get_arr() public view returns (uint[] memory){
        return arr;
    }
}
