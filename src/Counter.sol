// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

contract Counter {
    constructor(uint256 _initialValue) {
        current = _initialValue;
    }

    uint256 public current;

    function setNumber(uint256 newNumber) public {
        current = newNumber;
    }

    function increment() public {
        current++;
    }
}
