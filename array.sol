// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract SimpleArray{
    uint [] num;

    function addNumber(uint _number) public{
        num.push(_number);
    }
    function getNumber(uint _index) public view returns (uint){
        require(_index<num.length,"Index not listed yet");
        return num[_index];
    }

    function getAll () public view returns (uint [] memory){
        return num;
    }

    function getFirst () public view returns (uint){
        return num[0];
    }

    function remove_Number() public{
        num.pop();
}
}