// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Game.sol";
import "./Player.sol";

contract GameTest is Test {

    function testConstructor() public {
        address a1 = vm.addr(1);
        address a2 = vm.addr(2);
        Game game = new Game();
        game.enterGame(a1);
        game.enterGame(a2);
        game.startGame(52);



        // vm.expectRevert(Game.SamePlayer.selector);
        // new Game(a, a);
    }

    // // TODO create mint manager or something
    // function testCardMinting() public {
    //     Card cardType = new Card("Test Card");
    //     address ownerAddress = vm.addr(1);
    //     uint tokenId = cardType.mint(ownerAddress);
    //     require(cardType.ownerOf(tokenId) == ownerAddress);
    //     //require(cardType.ownerOf(tokenId) != msg.sender);
    // }


    // function testGame() public {
    //     Card cardType = new Card("Test Card");
    //     Player a = new Player(vm.addr(1));
    //     Player b = new Player(vm.addr(2));

    //     new Game(a, b);
    // }

    // function testPlayer() public {
    //     Player a = new Player(msg.sender);
    //     require(a.playerAddress() == msg.sender);

    //     a.createDeck("name", "description");
    // }

    // function mintCardsForPlayer(Card cardType, address playerAddress) private returns (uint) {
    //     return cardType.mint(playerAddress);
    // }
    
}
