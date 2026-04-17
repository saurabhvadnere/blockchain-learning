// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Istore {
    function getItem(uint indexx) external view returns (string memory, uint);
}

contract ReadVal{

    Istore access_store;

    constructor (address store_address){
        access_store = Istore(store_address);
    }

    function read_store(uint indexx) public view returns (string memory, uint){
       return access_store.getItem(indexx);
    }
}