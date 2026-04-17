// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./calculator.sol";

contract AreaCalculator{
    Calculator Area;
    
    constructor (address calculator){
        Area = Calculator(calculator);
    }

    function InchSqFt (uint Length, uint Width) public view returns (uint) {
       return Area.multi(Length,Width);
    }
}