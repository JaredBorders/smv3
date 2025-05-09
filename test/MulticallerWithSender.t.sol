// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.27;

import {Bootstrap} from "test/utils/Bootstrap.sol";
import {MulticallerWithSender as MWS} from "src/utils/MulticallerWithSender.sol";
import {EIP7412} from "src/utils/EIP7412.sol";
import {EIP7412Mock} from "test/utils/mocks/EIP7412Mock.sol";

contract MulticallerWithSenderTest is Bootstrap {
    MWS mws;
    EIP7412Mock eip7412Mock;
    address constant DEPLOYED_ENGINE =
        0xB7743A30cE805BcA100e048324d3398530b4547c;
    address payable constant DEPLOYED_MWS =
        payable(0x138A347ae9607dbc119620b93aAf2c71fDeF6726);
    uint256 constant BASE_BLOCK_NUMBER_AFTER_DEPLOYMENT = 23_799_829;
    uint256 constant ETH_PRICE_AFTER_DEPLOYMENT = 4040;

    function setUp() public {
        vm.rollFork(BASE_BLOCK_NUMBER_AFTER_DEPLOYMENT);
        initializeBase();

        mws = MWS(DEPLOYED_MWS);
        eip7412Mock = new EIP7412Mock();

        /// @dev this is needed because MWS hardcodes the live Engine contract address
        /// therefore we cannot use our boostrap test state and must reprovide permission
        vm.startPrank(ACTOR);
        perpsMarketProxy.grantPermission({
            accountId: accountId,
            permission: ADMIN_PERMISSION,
            user: DEPLOYED_ENGINE
        });
        vm.stopPrank();
    }
}

contract MulticallerWithSenderEngine is MulticallerWithSenderTest {
    function test_multicall_engine_depositCollateralETH() public {
        uint256 availableMargin =
            uint256(perpsMarketProxy.getAvailableMargin(accountId));
        assertEq(availableMargin, 0);

        vm.deal(ACTOR, 2 ether);

        bytes[] memory data = new bytes[](2);
        uint256[] memory values = new uint256[](2);

        data[0] = abi.encodeWithSelector(
            engine.depositCollateralETH.selector, accountId, 1 ether, 1
        );

        values[0] = 1 ether;

        data[1] = abi.encodeWithSelector(
            engine.depositCollateralETH.selector, accountId, 1 ether, 1
        );

        values[1] = 1 ether;

        vm.startPrank(ACTOR);
        mws.aggregateWithSender{value: values[0] + values[1]}(data, values);
        vm.stopPrank();

        availableMargin =
            uint256(perpsMarketProxy.getAvailableMargin(accountId));
        uint256 expectedMargin = 2 ether * ETH_PRICE_AFTER_DEPLOYMENT;
        assertWithinTolerance(expectedMargin, availableMargin, 3);
    }

    function test_multicall_engine_fulfillOracleQuery_depositCollateralETH()
        public
    {
        uint256 availableMargin =
            uint256(perpsMarketProxy.getAvailableMargin(accountId));
        assertEq(availableMargin, 0);

        vm.deal(ACTOR, 5 + 1 ether);

        bytes[] memory data = new bytes[](2);
        uint256[] memory values = new uint256[](2);

        // call mock oracle to simulate payable function call
        data[0] = abi.encodeWithSelector(
            EIP7412.fulfillOracleQuery.selector,
            address(eip7412Mock),
            abi.encodePacked("")
        );

        values[0] = 5;

        data[1] = abi.encodeWithSelector(
            engine.depositCollateralETH.selector, accountId, 1 ether, 1
        );

        values[1] = 1 ether;

        vm.startPrank(ACTOR);
        mws.aggregateWithSender{value: values[0] + values[1]}(data, values);
        vm.stopPrank();

        availableMargin =
            uint256(perpsMarketProxy.getAvailableMargin(accountId));
        uint256 expectedMargin = 1 ether * ETH_PRICE_AFTER_DEPLOYMENT;
        assertWithinTolerance(expectedMargin, availableMargin, 3);
    }
}
