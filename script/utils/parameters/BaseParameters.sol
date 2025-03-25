// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.27;

contract BaseParameters {
    // Base PDAO address
    address public constant PDAO = 0xbb63CA5554dc4CcaCa4EDd6ECC2837d5EFe83C82;

    address public constant PERPS_MARKET_PROXY = address(0);

    address public constant SPOT_MARKET_PROXY = address(0);

    address public constant USD_PROXY = address(0);

    // https://usecannon.com/packages/synthetix-perps-market/3.3.5/8453-andromeda
    address public constant PERPS_MARKET_PROXY_ANDROMEDA =
        0x0A2AF931eFFd34b81ebcc57E3d3c9B1E1dE1C9Ce;

    // https://usecannon.com/packages/synthetix-spot-market/3.3.5/8453-andromeda
    address public constant SPOT_MARKET_PROXY_ANDROMEDA =
        0x18141523403e2595D31b22604AcB8Fc06a4CaA61;

    // https://usecannon.com/packages/synthetix/3.3.5/8453-andromeda
    address public constant USD_PROXY_ANDROMEDA =
        0x09d51516F38980035153a554c26Df3C6f51a23C3;

    // https://basescan.org/token/0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913
    address public constant USDC = 0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913;

    address public constant WETH = 0x4200000000000000000000000000000000000006;

    // https://usecannon.com/packages/synthetix-spot-market/3.3.5/84531-andromeda
    uint128 public constant SUSDC_SPOT_MARKET_ID = 1;

    address public constant ZAP = 0x547f8fE03b4C4F6A031e69a52891eD016fC9eA49;

    address payable public constant PAY =
        payable(0x067e8C201Cc9CF33e556f8A0d75b91276c9af3D6);

    address public constant CBBTC = 0xcbB7C0000aB88B473b1f5aFd9ef808440eed33Bf;

    address public constant CBETH = 0x2Ae3F1Ec7F1F5012CFEab0185bfc7aa3cf0DEc22;

    address public constant WSTETH = 0xc1CBa3fCea344f92D9239c08C0568f6F2F0ee452;

    // https://basescan.org/address/0x729ef31d86d31440ecbf49f27f7cd7c16c6616d2
    address public constant BASE_SSTATA =
        0x729Ef31D86d31440ecBF49f27F7cD7c16c6616d2;
}
