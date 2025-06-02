// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.27;

import { Slot } from "v3/V3Types.sol";

interface IV3 {
    function store(Slot _slot) external;

    function load(Slot _slot) external view returns (uint256);
}
