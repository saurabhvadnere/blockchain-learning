// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ProductInventory {

    struct Product {
        string name;
        uint price;
        uint quantity;
    }

    mapping(uint => Product) public products;

    function addProduct(uint id, string memory _name, uint _price, uint _qty) public {
        products[id] = Product(_name, _price, _qty);
    }

    function buyProduct(uint id, uint qty) public {

        require(products[id].quantity >= qty, "Not enough stock");

        products[id].quantity -= qty;
    }

    function getProduct(uint id) public view returns(string memory, uint, uint){
        Product memory p = products[id];
        return (p.name, p.price, p.quantity);
    }

}