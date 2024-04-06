// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/interfaces/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/extensions/ERC20Permit.sol";
import "@openzeppelin/contracts/access/AccessControl.sol";

contract stERC20Token is ERC20, ERC20Permit, AccessControl {
    using SafeERC20 for IERC20;
    using Address for address;
    using SafeMath for uint256;

    bytes32 public constant MINTER_ROLE = keccak256("MINTER_ROLE");
    bytes32 public constant BURNER_ROLE = keccak256("BURNER_ROLE");

    constructor(
        string memory _name,
        string memory _symbol
    )
        ERC20(_name, _symbol)
        ERC20Permit(_name)
    {
        _grantRole(DEFAULT_ADMIN_ROLE, _msgSender());
        _grantRole(MINTER_ROLE, _msgSender());
        _grantRole(BURNER_ROLE, _msgSender());
    }

    function mint(
        address _to,
        uint256 _amount
    )
        external
        onlyRole(MINTER_ROLE)
    {
        _mint(_to, _amount);
    }

    function burn(uint256 _amount) external onlyRole(BURNER_ROLE) {
        _burn(_msgSender(), _amount);
    }

    function setMinterRole(address _minter)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        _setupRole(MINTER_ROLE, _minter);
    }

    function setBurnerRole(address _burner)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        _setupRole(BURNER_ROLE, _burner);
    }

    function revokeMinterRole(address _minter)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        revokeRole(MINTER_ROLE, _minter);
    }

    function revokeBurnerRole(address _burner)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        revokeRole(BURNER_ROLE, _burner);
    }

    fallback() external {
        revert("stToken: fallback function is not allowed");
    }

    receive() external payable {
        revert("stToken: receive function is not allowed");
    }
}
