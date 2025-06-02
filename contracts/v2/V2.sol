// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

import { IV2, SlotOigin } from "v2/interfaces/IV2.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";

contract V2 is IV2, Ownable {
    mapping(address => uint256) public slot1;
    mapping(address => uint256) public slot2;

    constructor(address[] memory _keys, uint256[] memory _values, SlotOigin[] memory _slot) Ownable(msg.sender) {
        for (uint256 i = 0; i < _keys.length; i++) {
            _slot[i] == SlotOigin.SLOT_1 ? slot1[_keys[i]] = _values[i] : slot2[_keys[i]] = _values[i];
        }
    }

    function set(address _key, SlotOigin _slot, uint256 _value) external override onlyOwner {
        _slot == SlotOigin.SLOT_1 ? slot1[_key] = _value : slot2[_key] = _value;
    }

    function get(address _key, SlotOigin _slot) external view override returns (uint256) {
        return _slot == SlotOigin.SLOT_1 ? slot1[_key] : slot2[_key];
    }
}
