// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Store {

    event store_product(address indexed, string store_product,uint store_price);

    struct Item {
        string product;
        uint price;
    }

    Item[] public items;

    function storeValue(string memory _product, uint _price) public {
        items.push(Item(_product, _price));

        emit store_product(msg.sender, _product, _price);
    }

    function getItem(uint number) public view returns (string memory, uint) {
        require(number > 0 && number <= items.length, "Invalid item number");

        uint index = number - 1; // convert to 0-based index
        return (items[index].product, items[index].price);
    }

    function get_All_items () public view returns (Item[] memory){
        return items;
    }
}
