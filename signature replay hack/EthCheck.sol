// SPDX-License-Identifier: MIT

pragma solidity >=0.6.0 <0.8.0;
import "github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.3/contracts/cryptography/ECDSA.sol";

contract EthCheck {
    using ECDSA for bytes32;
    address public owner;
    uint256 public nonce;

    constructor() payable {
        owner = msg.sender;
    }

    function withdraw(
        uint256 _amount,
        uint256 _nonce,
        bytes memory _signature
    ) public {
        require(_nonce == nonce++);
        bytes32 hash = keccak256(
            abi.encodePacked(msg.sender, _amount, _nonce, address(this))
        );
        bytes32 signedMsg = hash.toEthSignedMessageHash();
        require(owner == signedMsg.recover(_signature));
        msg.sender.transfer(_amount);
    }

    receive() external payable {}

    function destroy(address payable addr) public {
        require(msg.sender == owner);
        selfdestruct(addr);
    }
}
