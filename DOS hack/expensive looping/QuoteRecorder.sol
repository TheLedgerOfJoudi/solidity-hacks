// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract QuoteRecorder {
    address payable public currentQuoteLover;
    address public owner;
    uint256 public balance;
    string public currentQuote;
    address[] public recorders;

    constructor() {
        owner = msg.sender;
    }

    function record(string memory quote) external payable {
        require(msg.value > balance);
        currentQuoteLover.transfer(balance);
        balance = msg.value;
        currentQuoteLover = payable(msg.sender);
        currentQuote = quote;
        recorders.push(msg.sender);
    }

    function reward() public view {
        require(msg.sender == owner);
        for (uint256 i = 0; i < recorders.length; i++) {
            //supposing that distributeToken is implemented
            distributeToken(recorders[i], 10);
        }
    }
}
