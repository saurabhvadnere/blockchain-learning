// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract ParkingSystem {

    uint public totalSlots = 5;
    uint public occupiedSlots;

    // Park a vehicle
    function park() public {

        // Check if parking is full
        if (occupiedSlots == totalSlots) {
            revert("Parking full");
        }

        occupiedSlots++;
    }

    // Leave parking
    function leave() public {

        // Check if parking is already empty
        require(occupiedSlots > 0, "No cars to remove");

        occupiedSlots--;
    }

    // Check internal consistency
    function check() public view {
        assert(occupiedSlots <= totalSlots);
    }
}