// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Locked {
    bool mutex = false;
    mapping(address => uint256) public balances;

    function deposit() external payable {
        balances[msg.sender] += msg.value;
    }

    function withdrawAll() external {
        require(!mutex);
        require(balances[msg.sender] >= 0);
        uint256 amount = balances[msg.sender];
        balances[msg.sender] = 0;
        mutex = true;
        (bool sent, ) = msg.sender.call{value: amount}("");
        require(sent);
        mutex = false;
    }

    function transfer(address payable _to, uint256 amount) public {
        require(!mutex);
        require(balances[msg.sender] >= amount);
        balances[msg.sender] -= amount;
        balances[_to] += amount;
    }

    receive() external payable {}

    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }
}
