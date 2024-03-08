// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;


contract sendMeCrypto {
   // Create an event when a message is written.
   event NewMemo(
    address indexed from,
    uint256 timesamp,
    string name,
    string message

   );

   //Message Struct
   struct Memo {
    address from;
    uint256 timesamp;
    string name;
    string message;
   }

    //List of memos recieved from participants.
    Memo[] memos;


    //This is the address of the contract deployer.
   address payable owner;


    //Deploy Logic only ran once during deployment
    constructor() {
        owner = payable(msg.sender);
    }

}
