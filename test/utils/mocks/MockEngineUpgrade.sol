// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.27;

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
        address payable _pay,
        address _usdc,
        address _weth,
        address _sStataUSDCProxy
    )
        Engine(
            _perpsMarketProxy,
            _spotMarketProxy,
            _sUSDProxy,
            _pDAO,
            _zap,
            _pay,
            _usdc,
            _weth,
            _sStataUSDCProxy
        )
    {}

    function echo(string memory message) public pure returns (string memory) {
        return message;
    }
}
