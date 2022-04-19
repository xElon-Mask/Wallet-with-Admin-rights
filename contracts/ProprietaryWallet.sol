// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

import "./Owner.sol";

contract ProprietaryWallet is Owner {

    struct Payment {
        uint amount;
        uint timestamp;
    }

    struct Balance {
        uint totalBalance;
        uint numPayments;
        mapping(uint => Payment) payments;
    }

    mapping(address => Balance) Wallets;

    function getBalance() public isOwner view returns(uint) {
        return address(this).balance;
    }

    function withdrawAllMoney(address payable _to) public {
        uint amount = Wallets[msg.sender].totalBalance;
        Wallets[msg.sender].totalBalance = 0;
        _to.transfer(amount);
    }

    receive() external payable {
        Payment memory thisPayment = Payment(msg.value, block.timestamp);
        Wallets[msg.sender].totalBalance += msg.value;
        Wallets[msg.sender].payments[Wallets[msg.sender].numPayments] = thisPayment;
        Wallets[msg.sender].numPayments++;
    }


}