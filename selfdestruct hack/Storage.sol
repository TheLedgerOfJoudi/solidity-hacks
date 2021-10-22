// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract Storage {
    uint256 public number;
    address payable public owner;

    constructor() {
        owner = payable(msg.sender);
    }

    function setNumber(uint256 num) public {
        number = num;
    }

    function destroy() public {
        require (msg.sender == owner);
        selfdestruct(owner);
    }
}

