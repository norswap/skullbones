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

function bytesToCard(uint8 deckSize, bytes1 id) pure returns (Card memory) {
    Card memory card;
    card.id = id;

    uint8 cardNumber = uint8(id);
    uint8 cardsPerSuit = deckSize / 4;

    card.suit = CardSuit(uint8(cardNumber / cardsPerSuit));
    card.value = CardValue(uint8(12 - (cardNumber % cardsPerSuit)));

    return card;
}