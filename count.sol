// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Counter {
    uint count;

    function increment() public {
        count += 1;
        // count = count + 1;
    }

    function decrement() public {
        require(count >= 5, "Count is zero");
        count -= 1;
        // count = count - 1;
    }

    function getcount() public view returns(uint){
        return count;
    }
}