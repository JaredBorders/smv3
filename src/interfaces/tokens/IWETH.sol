// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.27;

interface IWETH {
    function deposit() external payable;
    function withdraw(uint256) external;
    function approve(address guy, uint256 wad) external returns (bool);
    function transfer(address dst, uint256 wad) external returns (bool);
    function transferFrom(address src, address dst, uint256 wad)
        external
        returns (bool);
    function balanceOf(address account) external view returns (uint256);
    function name() external view returns (string memory);
}
