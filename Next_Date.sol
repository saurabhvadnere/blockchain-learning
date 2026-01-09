// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract NextDate {

    function getNextDate(uint day, uint month, uint year) public pure returns (uint, uint, uint) {
        
        // Days in each month
    uint[12] memory daysInMonth = [uint(31), uint(28), uint(31), uint(30),
                               uint(31), uint(30), uint(31), uint(31),
                               uint(30), uint(31), uint(30), uint(31)];

        // Check leap year (Feb = 29 days)
        if ((year % 400 == 0) || (year % 4 == 0 && year % 100 != 0)) {
            daysInMonth[1] = 29;
        }

        // Increase day
        day++;

        // If day exceeds the month's limit
        if (day > daysInMonth[month - 1]) {
            day = 1;
            month++;

            // If month exceeds 12 → new year starts
            if (month > 12) {
                month = 1;
                year++;
            }
        }

        return (day, month, year);
    }
}
