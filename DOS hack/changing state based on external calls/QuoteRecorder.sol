// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract QuoteRecorder {

   address payable currentQuoteLover;
   uint public balance;
   string public currentQuote;
   
   function record (string memory quote) external payable{
       require (msg.value > balance);
       currentQuoteLover.transfer{value : balance}();
       balance = msg.value;
       currentQuoteLover = msg.sender;
       currentQuote = quote;
   }
   
   
}