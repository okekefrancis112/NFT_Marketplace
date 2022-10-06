// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

    import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

    /// @title This is a swap contract for the NFT Market
    /// @author team unicorn


contract Swap {

    // Declaration of variables
    IERC20 token;
    uint public rate = 10;

    event swapped(address indexed addr, uint indexed amount);
    event Rate(uint rate);


    /// @param _token: this is the token's contract address
    constructor (IERC20 _token){
        token = _token;
    }


    /// @dev this function allows  users to swap their native tokens for ours to be able to perform transaction on our platform
    function swap() public payable {
        require(msg.value > 0, "Not enough balance");
        require(msg.sender != address(0), "Cannot transfer to address zero");

        uint transferrable = msg.value * rate;
        token.transfer(msg.sender, transferrable);

        emit swapped(msg.sender, transferrable);
    }

    /// @dev this function allows it to be possible to change the exchange rate
    /// @param _rate: this is the swap's exchange rate
    function editRate(uint _rate) public {
        rate = _rate;

        emit Rate(_rate);
    }

    receive() external payable{}
}