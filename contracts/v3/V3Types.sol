// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.27;

using TypesHelper for Slot global;

type Slot is uint256;

library TypesHelper {
    function store(Slot _slot, uint256 _value) internal {
        assembly {
            sstore(_slot, _value)
        }
    }

    function load(Slot _slot) internal view returns (uint256 value) {
        assembly {
            value := sload(_slot)
        }
    }
}
