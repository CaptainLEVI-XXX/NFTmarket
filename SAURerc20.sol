// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
contract SaurabhToken is ERC20("Saur", "SY")  {
    function mintSY() public {
        _mint(msg.sender,1000*10**18 );
    }
}
 //congrats you have have created your own ERC20 token 