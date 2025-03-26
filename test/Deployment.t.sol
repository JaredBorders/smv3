// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.27;

import {Engine, Setup} from "script/Deploy.s.sol";
import {IEngine} from "src/interfaces/IEngine.sol";
import {IERC20} from "src/interfaces/tokens/IERC20.sol";
import {Test} from "lib/forge-std/src/Test.sol";
import {BaseParameters} from "script/utils/parameters/BaseParameters.sol";

contract DeploymentTest is Test, Setup, BaseParameters {
    Setup setup;

    address internal perpsMarketProxy = address(0x1);
    address internal spotMarketProxy = address(0x2);
    address internal sUSDProxy = address(0x3);
    address internal pDAO = address(0x4);
    address internal usdc = address(0x5);
    uint128 internal sUSDCId = 1;
    address internal sUSDC = address(0x6);
    address internal zap = address(0x7);
    address internal weth = address(0x8);
    address payable internal pay = payable(address(0x9));
    address internal stataUSDC = address(0x10);

    /// keccak256(abi.encodePacked("Synthetic USD Coin Spot Market"))
    bytes32 internal constant _HASHED_SUSDC_NAME =
        0xdb59c31a60f6ecfcb2e666ed077a3791b5c753b5a5e8dc5120f29367b94bbb22;

    address internal dai = address(0x50c5725949A6F0c72E6C4a641F24049A917DB0Cb);

    function setUp() public {
        setup = new Setup();

        // mock call to $USDC contract that occurs in Zap constructor
        vm.mockCall(
            usdc,
            abi.encodeWithSelector(IERC20.decimals.selector),
            abi.encode(8)
        );
    }

    function test_deploy() public {
        (Engine engine) = Setup.deploySystem({
            perpsMarketProxy: PERPS_MARKET_PROXY_ANDROMEDA,
            spotMarketProxy: SPOT_MARKET_PROXY_ANDROMEDA,
            sUSDProxy: USD_PROXY_ANDROMEDA,
            pDAO: PDAO,
            zap: ZAP,
            pay: PAY,
            usdc: USDC,
            weth: WETH,
            sStataUSDC: BASE_SSTATA
        });

        assertTrue(address(engine) != address(0x0));
    }

    function test_deploy_perps_market_proxy_zero_address() public {
        try setup.deploySystem({
            perpsMarketProxy: address(0),
            spotMarketProxy: spotMarketProxy,
            sUSDProxy: sUSDProxy,
            pDAO: pDAO,
            zap: zap,
            pay: pay,
            usdc: usdc,
            weth: weth,
            sStataUSDC: stataUSDC
        }) {} catch (bytes memory reason) {
            assertEq(bytes4(reason), IEngine.ZeroAddress.selector);
        }
    }

    function test_deploy_spot_market_proxy_zero_address() public {
        try setup.deploySystem({
            perpsMarketProxy: perpsMarketProxy,
            spotMarketProxy: address(0),
            sUSDProxy: sUSDProxy,
            pDAO: pDAO,
            zap: zap,
            pay: pay,
            usdc: usdc,
            weth: weth,
            sStataUSDC: stataUSDC
        }) {} catch (bytes memory reason) {
            assertEq(bytes4(reason), IEngine.ZeroAddress.selector);
        }
    }

    function test_deploy_susd_proxy_zero_address() public {
        try setup.deploySystem({
            perpsMarketProxy: perpsMarketProxy,
            spotMarketProxy: spotMarketProxy,
            sUSDProxy: address(0),
            pDAO: pDAO,
            zap: zap,
            pay: pay,
            usdc: usdc,
            weth: weth,
            sStataUSDC: stataUSDC
        }) {} catch (bytes memory reason) {
            assertEq(bytes4(reason), IEngine.ZeroAddress.selector);
        }
    }

    function test_deploy_zap_zero_address() public {
        try setup.deploySystem({
            perpsMarketProxy: perpsMarketProxy,
            spotMarketProxy: spotMarketProxy,
            sUSDProxy: sUSDProxy,
            pDAO: pDAO,
            zap: address(0),
            pay: pay,
            usdc: usdc,
            weth: weth,
            sStataUSDC: stataUSDC
        }) {} catch (bytes memory reason) {
            assertEq(bytes4(reason), IEngine.ZeroAddress.selector);
        }
    }

    function test_deploy_pay_zero_address() public {
        try setup.deploySystem({
            perpsMarketProxy: perpsMarketProxy,
            spotMarketProxy: spotMarketProxy,
            sUSDProxy: sUSDProxy,
            pDAO: pDAO,
            zap: zap,
            pay: payable(address(0)),
            usdc: usdc,
            weth: weth,
            sStataUSDC: stataUSDC
        }) {} catch (bytes memory reason) {
            assertEq(bytes4(reason), IEngine.ZeroAddress.selector);
        }
    }

    function test_deploy_usdc_zero_address() public {
        try setup.deploySystem({
            perpsMarketProxy: perpsMarketProxy,
            spotMarketProxy: spotMarketProxy,
            sUSDProxy: sUSDProxy,
            pDAO: pDAO,
            zap: zap,
            pay: pay,
            usdc: address(0),
            weth: weth,
            sStataUSDC: stataUSDC
        }) {} catch (bytes memory reason) {
            assertEq(bytes4(reason), IEngine.ZeroAddress.selector);
        }
    }

    function test_deploy_weth_zero_address() public {
        try setup.deploySystem({
            perpsMarketProxy: perpsMarketProxy,
            spotMarketProxy: spotMarketProxy,
            sUSDProxy: sUSDProxy,
            pDAO: pDAO,
            zap: zap,
            pay: pay,
            usdc: usdc,
            weth: address(0),
            sStataUSDC: stataUSDC
        }) {} catch (bytes memory reason) {
            assertEq(bytes4(reason), IEngine.ZeroAddress.selector);
        }
    }

    function test_deploy_stata_zero_address() public {
        try setup.deploySystem({
            perpsMarketProxy: perpsMarketProxy,
            spotMarketProxy: spotMarketProxy,
            sUSDProxy: sUSDProxy,
            pDAO: pDAO,
            zap: zap,
            pay: pay,
            usdc: usdc,
            weth: weth,
            sStataUSDC: address(0)
        }) {} catch (bytes memory reason) {
            assertEq(bytes4(reason), IEngine.ZeroAddress.selector);
        }
    }

    function test_deploy_usdc_incorrect_token() public {
        try setup.deploySystem({
            perpsMarketProxy: PERPS_MARKET_PROXY_ANDROMEDA,
            spotMarketProxy: SPOT_MARKET_PROXY_ANDROMEDA,
            sUSDProxy: USD_PROXY_ANDROMEDA,
            pDAO: PDAO,
            zap: ZAP,
            pay: PAY,
            usdc: dai,
            weth: WETH,
            sStataUSDC: BASE_SSTATA
        }) {} catch (bytes memory reason) {
            assertEq(bytes4(reason), IEngine.IncorrectToken.selector);
        }
    }

    function test_deploy_weth_incorrect_token() public {
        try setup.deploySystem({
            perpsMarketProxy: PERPS_MARKET_PROXY_ANDROMEDA,
            spotMarketProxy: SPOT_MARKET_PROXY_ANDROMEDA,
            sUSDProxy: USD_PROXY_ANDROMEDA,
            pDAO: PDAO,
            zap: ZAP,
            pay: PAY,
            usdc: USDC,
            weth: dai,
            sStataUSDC: BASE_SSTATA
        }) {} catch (bytes memory reason) {
            assertEq(bytes4(reason), IEngine.IncorrectToken.selector);
        }
    }

    function test_deploy_stata_incorrect_token() public {
        try setup.deploySystem({
            perpsMarketProxy: PERPS_MARKET_PROXY_ANDROMEDA,
            spotMarketProxy: SPOT_MARKET_PROXY_ANDROMEDA,
            sUSDProxy: USD_PROXY_ANDROMEDA,
            pDAO: PDAO,
            zap: ZAP,
            pay: PAY,
            usdc: USDC,
            weth: WETH,
            sStataUSDC: dai
        }) {} catch (bytes memory reason) {
            assertEq(bytes4(reason), IEngine.IncorrectToken.selector);
        }
    }
}
