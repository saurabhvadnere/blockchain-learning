// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract PayUser {

    function sendETH(address payable user) public payable {
        require(msg.value > 0, "Send ETH");
        (bool success, ) = user.call{value: msg.value}("");
        require(success, "Transfer failed");
    }
}
