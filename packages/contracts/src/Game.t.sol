// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "forge-std/console2.sol";
import "./Game.sol";
import "./Card.sol";

contract GameTest is Test {

    uint deckSize = 24;
    bytes cards;

    function testConstructor() public {
        Game game = new Game();
        for (uint i = 1; i < 3; i++) {
            game.enterGame(vm.addr(i));
        }
        game.startGame(deckSize);

        address attacker = game.getAttackerAddress();
        cards.push(giveCardToPlayer(game, attacker, CardSuit.Spades, CardValue.Ace));
        cards.push(giveCardToPlayer(game, attacker, CardSuit.Diamonds, CardValue.Ace));

        vm.startPrank(attacker);
        game.firstAttack(cards);

        // vm.expectRevert(Game.SamePlayer.selector);
    }

    function giveCardToPlayer(Game game, address playerAddress, CardSuit suit, CardValue value) private returns (bytes1) {
        bytes1 card = cardToBytes(deckSize, suit, value);
        game.addCard(playerAddress, card);
        return card;
    }


    
}
