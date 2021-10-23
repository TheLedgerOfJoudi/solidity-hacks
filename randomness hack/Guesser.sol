// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Guesser {
    constructor () payable {}
    
    function guess(uint _guess) public payable{
        require (msg.value == 1 ether);
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
            if ((rand + _guess) % 2 == 0){
               payable(msg.sender).transfer(2 ether);
            }
    }
    
    receive() external payable{}
    function getBalance()public view returns (uint) {
        return address(this).balance;
    }
    function hat(address payable addr) public payable{
        selfdestruct(addr);
    }
}
