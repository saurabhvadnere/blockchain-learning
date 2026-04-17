// SPDX-License-Identifier: MIT
pragma solidity 0.8.0;

contract Constructor{

    uint public num;

    constructor(uint _number) {
        num = _number;
    }
}