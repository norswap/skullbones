pragma solidity ^0.8.0;

import "./CardType.sol";

contract Player {
    Card[][] public decks;

    constructor () {
        decks.push();

        CardType biguGob = new CardType("Small Goblin");
        CardType smolGob = new CardType("Big Goblin");

        decks[0].push(Card(biguGob, 1));
        decks[0].push(Card(smolGob, 1));
    }
}