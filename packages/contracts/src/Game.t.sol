// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Game.sol";
import "./Player.sol";

contract GameTest is Test {
    function testConstructor() public {
        Player a = new Player(vm.addr(1));
        Player b = new Player(vm.addr(2));
        new Game(a, b);

        vm.expectRevert(Game.SamePlayer.selector);
        new Game(a, a);
    }

    // TODO create mint manager or something
    function testCardMinting() public {
        CardType cardType = new CardType("Test CardType");
        address ownerAddress = vm.addr(1);
        uint tokenId = cardType.mint(ownerAddress);
        require(cardType.ownerOf(tokenId) == ownerAddress);
        //require(cardType.ownerOf(tokenId) != msg.sender);
    }


    function testGame() public {
        CardType cardType = new CardType("Test CardType");
        Player a = new Player(vm.addr(1));
        Player b = new Player(vm.addr(2));

        new Game(a, b);
    }

    function testPlayer() public {
        Player a = new Player(msg.sender);
        require(a.playerAddress() == msg.sender);

        a.createDeck("name", "description");
    }

    function mintCardsForPlayer(CardType cardType, address playerAddress) private returns (uint) {
        return cardType.mint(playerAddress);
    }
}
