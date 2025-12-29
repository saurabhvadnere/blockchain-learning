// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    Interface: Istore
    Defines the external functions of the Store contract
    that this contract needs to interact with.
*/
interface Istore {

    /*
        Function: getItem
        Reads a product and its price from the Store contract
        using a serial number (index).
    */
    function getItem(uint indexx) external view returns (string memory, uint);
}

/*
    Contract Name: ReadVal
    Description:
    This contract reads data from another deployed Store contract
    using an interface. It demonstrates inter-contract communication
    in Solidity.
*/
contract ReadVal {

    /*
        Interface reference to access the Store contract.
        It holds the address of the deployed Store contract.
    */
    Istore access_store;

    /*
        Constructor
        Initializes the interface with the deployed Store contract address.
    */
    constructor(address store_address) {
        access_store = Istore(store_address);
    }

    /*
        Function: read_store
        Calls the getItem function of the Store contract
        and returns the product name and price.
    */
    function read_store(uint indexx) public view returns (string memory, uint) {
        return access_store.getItem(indexx);
    }
}
