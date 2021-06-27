pragma solidity ^0.8.1;

contract Trust {
  
  struct Staff {
      uint ammount;
      uint maturity;
      bool paid;
  }        
    
   mapping(address => Staff) public staffs;     
   address public admin;
   
   constructor() {
       admin = msg.sender;
   }
   
   function addStaff(address staff, uint timeTomaturity) external payable {
       require(msg.sender ==  admin, 'only admin');
       require(staffs[msg.sender].ammount == 0, 'staff already exist');
       staffs[staff] = Staff(msg.value, block.timestamp + timeTomaturity, false);
   }
    
   function witdraw() external {
       Staff storage staff = staffs[msg.sender];
       require(staff.maturity <= block.timestamp, 'too early');
       require(staff.ammount > 0, 'only staff can witdraw');
       require(staff.paid == false, 'paid already');
       staff.paid = true;
       payable(msg.sender).transfer(staff.ammount);
   }
}