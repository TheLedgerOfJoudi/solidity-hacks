// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract QuoteRecorder {
    address payable public currentQuoteLover;
    uint256 public balance;
    string public currentQuote;

    function record(string memory quote) external payable {
        require(msg.value > balance);
        (bool sent, ) = currentQuoteLover.call{value: balance}("");
        require(sent);
        balance = msg.value;
        currentQuoteLover = payable(msg.sender);
        currentQuote = quote;
    }
}
