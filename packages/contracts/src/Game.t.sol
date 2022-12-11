// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Game.sol";
import "./Player.sol";

contract GameTest is Test {
    function testConstructor() public {
        Player a = new Player();
        Player b = new Player();
        new Game(a, b);
    }

    function testCardMinting() public {
        CardType cardType = new CardType("Test CardType");
        cardType.mint(msg.sender);
    }
}
