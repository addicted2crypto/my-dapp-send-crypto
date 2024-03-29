// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;


contract BuyMeCrypto {
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

    //List array of memos recieved from participants.
    Memo[] memos;


    //This is the address of the contract deployer.
   address payable owner;


    //Deploy Logic only runs once during deployment with wallet as msg.sender
    constructor() {
        owner = payable(msg.sender);
    }

    /** 
        * @dev the function to be able to send the contract crypto 
        * @param _name name of the crypto sender
        * @param _message The message body from the crypto sender
        */

    function buyCrypto(string memory _name, string memory _message) public payable {
        require(msg.value > 0, "Sending 0 is just a message");


        //This adds the memo to storage!!
        memos.push(Memo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        ));
        
        //Emit(create) a logged event when a new memo is created.
        emit NewMemo(
            msg.sender,
            block.timestamp,
            _name,
            _message
        );

    }

    
    /** 
        * @dev Send the balance from contract to wallet of contract creator(owner).
        */

    function withdrawCrypto() public {
       //anyone can call this but it is sent to the creator.
        require(owner.send(address(this).balance));
    }

    /** 
        * @dev Retrieve all memos created and then stored in the memo array on the blockchain.
        */


    function getMemos() public view returns(Memo[] memory){
        return memos;

    }

}
