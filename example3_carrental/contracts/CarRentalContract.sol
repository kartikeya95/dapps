pragma solidity ^0.4.4;

contract CarRentalContract {

//Public address variable of creator
  address public Creator;
//New complex type car describing a car
  struct Car {
    int ID;
    string Make;
    string Model;
    string RegNo;
    string Color;
    int MileCount;
    address CurrentOwner;
    bool Available;
  }
//New complex type user
  struct User{
    string Name;
    string ID_Number;
  }
//Map every possible address to a user struct
  mapping(address => User) public Users;
//Dynamically sized array of Cars
  Car[] public cars;
//Event to add a car
  event CarAdded(string regno);
//Event to add a user
  event UserAdded(address user);
//Constructor to save the creator at the start of the contarct
  function CarRentalContract() {
    Creator=msg.sender;
  }
//Modifier to check for creator
  modifier IfCreator(){
    if (msg.sender!=Creator) revert();
    _;
  }
//Function to add a car to the catalogue
  function AddCar(
    int id,
    string make,
    string model,
    string regno,
    string color,
    int milecount,
  )
    IfCreator
  {
    Car vehicle;
    vehicle.ID=id;
    vehicle.Make=make;
    vehicle.Model=model;
    vehicle.RegNo=regno;
    vehicle.Color=color;
    vehicle.MileCount=milecount;
    vehicle.CurrentOwner=Creator;
    vehicle.Available=true;
    cars.push(vehicle);
    CarAdded(regno);
  }
//Function to add a user
  function AddUser(
    address ad,
    string name,
    string id_number
  )
    IfCreator
  {
    Users[ad].Name=name;
    Users[ad].ID_Number=id_number;
  }
//Function to get back a cars model, regno and
  function GetCar(string regno)
    IfCreator
    constant
    returns()
  {
    Car vehicle;
    for (int i=0; i<cars.length; i++)
    {
      vehicle=cars[i];
      if (vehicle.RegNo==regno) return car1;
      revert("Car does not exist");
    }
  }

}
