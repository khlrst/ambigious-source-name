// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.19;

enum SlotOigin {
    SLOT_1, // 0
    SLOT_2 // 1

}

interface IV2 {
    function set(address _key, SlotOigin _slot, uint256 _value) external;

    function get(address _key, SlotOigin _slot) external view returns (uint256);
}
