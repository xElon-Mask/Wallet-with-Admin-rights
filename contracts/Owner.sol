// SPDX-License-Identifier: GPL-3.0

pragma solidity 0.8.13;

contract Owner {

    address owner;

    constructor() {
        owner = msg.sender;
    }

    modifier isOwner() {
        require(msg.sender == owner, "You are not the owner of the wallet");
        _;
    }

}

