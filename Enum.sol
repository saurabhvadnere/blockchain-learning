// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract Car_Rental{

  enum Car_Type {Hatchback, Sedan, SUV, MUV, Coupe, Convertible, Electric}

  Car_Type public car_showroom;
  Car_Type constant Premium_car = Car_Type.Convertible;


  function getcar (Car_Type enter_sq) public {
    car_showroom = enter_sq;
  }

  // function sedan_car() public {
  //   car_showroom = Car_Type.Sedan;
  // }

  function EV () public {
    car_showroom = Car_Type.Electric;
  }

  function Premium_Car() public pure returns (uint){
    return uint(Premium_car);
  }

  function reset_choice () public {
    delete car_showroom; 
  }
}