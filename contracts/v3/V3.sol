// SPDX-License-Identifier: AGPL-3.0-only
pragma solidity ^0.8.27;

import { IV3 } from "v3/interfaces/IV3.sol";
import { Slot } from "v3/V3Types.sol";
import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { MockERC20 } from "fixtures/MockERC20.sol";

contract V3 is IV3, Ownable {
    address public immutable token;

    constructor(address _token) Ownable(msg.sender) {
        token = _token;
    }

    function store(Slot _slot) external override {
        _slot.store(MockERC20(token).balanceOf(msg.sender));
    }

    function load(Slot _slot) external view override returns (uint256) {
        return _slot.load();
    }
}
