// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Vulnerable {
    address public owner;

    constructor() payable {
        owner = msg.sender;
    }

    function withdraw(address payable _recipient) public {
        require(tx.origin == owner);
        _recipient.transfer(address(this).balance);
    }

    receive() external payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
