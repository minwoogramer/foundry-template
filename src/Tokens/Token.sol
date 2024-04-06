// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract TestToken is ERC20, Ownable {
    using SafeERC20 for ERC20;

    event Burned(address request, uint256 amount);

    constructor() ERC20("Test", "TDD") {
        _mint(msg.sender, (10 ** 9) * (10 ** 18));
    }

    function burn(uint256 _amount) external returns (bool) {
        _burn(msg.sender, _amount);
        emit Burned(msg.sender, _amount);
        return true;
    }
}
