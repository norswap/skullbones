// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "openzeppelin/token/ERC721/ERC721.sol";
import "openzeppelin/access/Ownable.sol";


enum CardValue { Two, Three, Four, Five, Six, Seven, Eight, Nine, Ten, Jack, King, Queen, Ace }
enum CardSuit { Spades, Clubs, Diamonds, Hearts }


struct Card {
    bytes1 id;
    CardSuit suit;
    CardValue value;
}

function bytesToCard(uint deckSize, bytes1 id) pure returns (Card memory) {
    Card memory card;
    card.id = id;

    uint cardNumber = uint8(id);
    uint cardsPerSuit = deckSize / 4;

    card.suit = CardSuit(uint(cardNumber / cardsPerSuit));
    card.value = CardValue(uint(12 - (cardNumber % cardsPerSuit)));

    //require(cardToBytes(deckSize, card.suit, card.value) == id);

    return card;
}

function getCardSuit(uint deckSize, bytes1 id) pure returns (CardSuit) {
    return CardSuit(uint(uint8(id) * 4 / deckSize));
}

function getCardValue(uint deckSize, bytes1 id) pure returns (CardValue) {
    return CardValue(uint(12 - (uint8(id) % (deckSize / 4))));
}

function cardToBytes(uint deckSize, CardSuit suit, CardValue value) pure returns (bytes1) {
    uint cardNumber = (uint(suit) * deckSize / 4) + 12 - uint(value);
    return bytes1(uint8(cardNumber));
}

function cardValueToCard(uint deckSize, CardSuit suit, CardValue value) pure returns (Card memory) {
    return Card(cardToBytes(deckSize, suit, value), suit, value);
}