// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/*
    Contract Name: Store
    Description:
    This smart contract allows users to store multiple products with prices
    on the blockchain. It also emits events whenever a new product is added
    and provides functions to retrieve stored items.
*/

contract Store {

    /*
        Event: store_product
        Emits when a new product is stored.
        indexed address allows filtering events by user address.
    */
    event store_product(
        address indexed user,
        string product_name,
        uint product_price
    );

    /*
        Struct: Item
        Represents a product with its name and price.
    */
    struct Item {
        string product;
        uint price;
    }

    /*
        Dynamic array to store all items.
        Public visibility automatically creates a getter.
    */
    Item[] public items;

    /*
        Function: storeValue
        Stores a new product and its price in the items array.
        Also emits an event for off-chain tracking (frontend, logs).
    */
    function storeValue(string memory _product, uint _price) public {
        // Add new item to storage
        items.push(Item(_product, _price));

        // Emit event after storing product
        emit store_product(msg.sender, _product, _price);
    }

    /*
        Function: getItem
        Returns a product and price using a serial number (1-based index).
        Converts user input to 0-based index internally.
    */
    function getItem(uint number) public view returns (string memory, uint) {
        // Validate input number
        require(number > 0 && number <= items.length, "Invalid item number");

        // Convert to 0-based index
        uint index = number - 1;

        // Return product details
        return (items[index].product, items[index].price);
    }

    /*
        Function: get_All_items
        Returns all stored items at once.
        Useful for frontend display.
    */
    function get_All_items() public view returns (Item[] memory) {
        return items;
    }
}

// contract deployed on sepolia testnet 
// contract address 0x006bDEDDEE20384B2d66628c504bDa20Ad3cC8f4
