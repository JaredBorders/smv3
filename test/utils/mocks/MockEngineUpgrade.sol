// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.20;

import {Engine} from "src/Engine.sol";

/// @title Example upgraded Engine contract for testing purposes
/// @author JaredBorders (jaredborders@pm.me)
contract MockEngineUpgrade is Engine {
    constructor(
        address _perpsMarketProxy,
        address _spotMarketProxy,
        address _sUSDProxy,
        address _pDAO,
        address _zap,
        address _usdc,
        address _weth
    ) Engine(_perpsMarketProxy, _spotMarketProxy, _sUSDProxy, _pDAO, _zap, _usdc, _weth) {}

    function echo(string memory message) public pure returns (string memory) {
        return message;
    }
}
