// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Insert_array{
    uint [] public arr=[10,20,30,40,50];

    function update_arr(uint index,uint val) public {
        arr.push(0);
        for (uint i=arr.length-1;i>index;i--)
    {
        arr[i]=arr[i-1];
    }
    arr[index]=val;
    }
    function get_arr() public view returns (uint[] memory){
        return arr;
    }
}
