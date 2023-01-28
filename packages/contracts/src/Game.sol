// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "openzeppelin/token/ERC721/ERC721.sol";
import {Card, CardSuit, CardValue, bytesToCard} from "./Card.sol";
import "./Player.sol";
import "forge-std/console2.sol";

contract Game {

    enum GameState {
        WAITING, DEALING, PLAYING, FINISHED
    }

    error SamePlayer();

    GameState state = GameState.WAITING;

    // in order of play turn
    Player[] players;
    // index in players - signifies whose turn it is
    uint8 turn;

    uint8 deckSize;
    bytes deck;
    CardSuit trump;

    constructor() {
       
    }

    function enterGame(address playerAddress) public {
        require (state == GameState.WAITING && players.length < 8);
        for (uint i = 0; i < players.length; i++) {
            require (players[i].playerAddress() != playerAddress);
        }
        players.push(new Player(playerAddress));
    }

    function startGame(uint8 _deckSize) public {
        require (state == GameState.WAITING && players.length > 1);
        require ((_deckSize == 24 || _deckSize == 36) && players.length <= 6 || _deckSize == 52 && players.length <= 8);
        deckSize = _deckSize;
        state = GameState.DEALING;
        generateDeck(deckSize);
        trump = bytesToCard(deckSize, deck[0]).suit;
        dealCards();
    }

    function dealCards() private {
        CardValue minCardValue = CardValue.Ace;
        for (uint8 playerI = 0; playerI < players.length; playerI++) {
            Player player = players[playerI];
            for (uint8 cardI = 0; cardI < 6; cardI++) {
                Card memory card = bytesToCard(deckSize, deck[deck.length - 1]);
                if (card.suit == trump && card.value < minCardValue) {
                    turn = playerI;
                    minCardValue = card.value;
                }
                player.giveCard(card);
                deck.pop();
            }
        }

    }

function generateDeck(uint8 deckSize) private {
    uint8[52] memory numberArr;

    for (uint8 i = 0; i < deckSize; i++) {
        numberArr[i] = i;
    }

    for (uint8 i = 0; i < deckSize; i++) {
        uint n = i + uint(keccak256(abi.encodePacked(block.timestamp))) % (deckSize - i);
        uint8 temp = numberArr[n];
        numberArr[n] = numberArr[i];
        numberArr[i] = temp;
    }

    for (uint8 i = 0; i < deckSize; i++) {
        deck.push(bytes1(numberArr[i]));
    }
}

    function nextTurn() public {
        turn = uint8((turn + 1) % players.length);
    }

    // function playCard(Card cardType, uint tokenId) external {
    //     require (msg.sender == players[turn].player.playerAddress() && msg.sender == cardType.ownerOf(tokenId));

    // }
}
