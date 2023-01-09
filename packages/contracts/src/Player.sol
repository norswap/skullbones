// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "./CardType.sol";

struct Deck {
    string name;
    string description;
    Card[] cards;
}

contract Player {
    // like playlists - owner is kept in CardType
    Deck[] public decks;
    address public playerAddress;

    constructor (address _playerAddress) {
        playerAddress = _playerAddress;
    }

    function createDeck(string calldata name, string calldata description) public returns (uint) {
        Deck storage deck = decks.push();
        deck.name = name;
        deck.description = description;
        return decks.length - 1;
    }

    function addCardToDeck(uint deckId, CardType cardType, uint cardId) public {
        require(cardType.ownerOf(cardId) == playerAddress);
        decks[deckId].cards.push(Card(cardType, cardId));
    }
}