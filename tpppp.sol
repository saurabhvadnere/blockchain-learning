// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {

   uint public count = 0;

   function increment() public {
       count = count + 1;
   }

   function decrement() public {
   require(count > 0, "Counter cannot be negative");
   count = count - 1;
}
   function getCount() public view returns(uint){
       return count;
   }
}   