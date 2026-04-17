// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Delete_array{
    uint [] public arr=[10,20,30,40,50];

    function del_arr(uint index) public {
        require(index<arr.length,"Index are not available");
        for (uint i=index; i<arr.length-1;i++)
        {
        arr[i]=arr[i+1];
        }
        arr.pop();
    }
    function get_arr() public view returns (uint[] memory){
        return arr;
    }
}
