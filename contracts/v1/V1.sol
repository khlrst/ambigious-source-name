// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.27;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract V1 is Ownable {
    mapping(address => uint256) public slot1;

    constructor(address[] memory _keys, uint256[] memory _values) Ownable(msg.sender) {
        for (uint256 i = 0; i < _keys.length; i++) {
            slot1[_keys[i]] = _values[i];
        }
    }

    function set(address _key, uint256 _value) public onlyOwner {
        slot1[_key] = _value;
    }
}
