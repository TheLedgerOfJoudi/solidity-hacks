// SPDX-License-Identifier: MIT

pragma solidity >=0.7.0 <0.9.0;

contract Vulnerable {
mapping(address => uint256) public balances;

function deposit() external payable {
    balances[msg.sender] += msg.value;
} 

function withdrawAll() external{
    require(balances[msg.sender] >= 0);
    (bool sent,) = msg.sender
    .call{value:balances[msg.sender]}("");
    require(sent);
    balances[msg.sender] = 0;
}

function transfer(address payable _to, uint256 amount) public{
    require(balances[msg.sender] >= amount);
    balances[msg.sender] -= amount;
    balances[_to] += amount;
}

receive () external payable{}

function getBalance()public view returns(uint256){
    return address(this).balance;
}

function destroy(address payable addr)public{
    selfdestruct(addr);
}

}