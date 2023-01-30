// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "openzeppelin/token/ERC721/ERC721.sol";
import "forge-std/console2.sol";
import "./Card.sol";

contract Game {

    enum GameState {
        WAITING, DEALING, FIRST_ATTACK, DEFEND, ATTACK, FINISHED
    }

    GameState state = GameState.WAITING;

    mapping(address => bytes) hands;
    address[] players; // in order of play turn
    uint defenderIndex;
    uint deckSize;
    bytes deck;
    bytes attackCards; // those that the defender has to beat
    bytes onTable; // beaten but still on table
    CardSuit trump;

    constructor() {
       
    }

    function enterGame(address playerAddress) public {
        require (state == GameState.WAITING, "Invalid game state. Must be WAITING");
        require (players.length < 8, "Can't have more than 8 players.");
        for (uint i = 0; i < players.length; i++) {
            require (players[i] != playerAddress, "Player already added.");
        }
        players.push(playerAddress);
    }

    function startGame(uint _deckSize) public {
        require (state == GameState.WAITING, "Invalid game state. Must be WAITING");
        require (players.length > 1, "There must be more than 1 player to start game.");
        require ((_deckSize == 24 || _deckSize == 36) && players.length <= 6 || _deckSize == 52 && players.length <= 8, "Invalid number of players vs deck size");
        deckSize = _deckSize;
        state = GameState.DEALING;
        generateDeck();
        dealCards();
        state = GameState.FIRST_ATTACK;
    }

    function generateDeck() private {
        uint[52] memory numberArr;

        // generate an array of 0, 1, 2..
        for (uint i = 0; i < deckSize; i++) {
            numberArr[i] = i;
        }

        // shuffle the array
        for (uint i = 0; i < deckSize; i++) {
            uint n = i + uint(keccak256(abi.encodePacked(block.timestamp))) % (deckSize - i);
            uint temp = numberArr[n];
            numberArr[n] = numberArr[i];
            numberArr[i] = temp;
        }

        // turn into bytes
        for (uint i = 0; i < deckSize; i++) {
            deck.push(bytes1(uint8(numberArr[i])));
        }
    }

    function dealCards() private {
        trump = bytesToCard(deckSize, deck[0]).suit;
        CardValue minCardValue = CardValue.Ace;
        uint playerToStart = 0;
        for (uint playerI = 0; playerI < players.length; playerI++) {
            for (uint cardI = 0; cardI < 6; cardI++) {
                Card memory card = bytesToCard(deckSize, deck[deck.length - 1]);
                // player with smallest trump starts
                if (card.suit == trump && card.value < minCardValue) {
                    playerToStart = playerI;
                    minCardValue = card.value;
                }
                hands[players[playerI]].push(card.id);
                deck.pop();
            }
        }
        defenderIndex = getNextTurn(playerToStart);
    }

    function getNextTurn(uint turn) public view returns (uint) {
        return (turn + 1) % players.length;
    }

    function getAttackerIndex() public view returns (uint) {
        return (defenderIndex > 0 ? defenderIndex : players.length) - 1;
    }

    function contains(bytes memory array, bytes1 item) private pure returns (bool) {
        for (uint i = 0; i < array.length; i++) {
            if (array[i] == item) {
                return true;
            }
        }
        return false;
    }

    function firstAttack(bytes calldata cards) public {
        require(state == GameState.FIRST_ATTACK, "Invalid game state. Must be FIRST_ATTACK");
        address attackerAddress = players[getAttackerIndex()];
        require (msg.sender == attackerAddress, "Sender address does not match attacker's address.");
        require(cards.length > 0 && cards.length <= 4, "Invalid number of cards, must be between 1 and 4.");

        address defenderAddress = players[defenderIndex];
        require(cards.length <= hands[defenderAddress].length, "More cards than the defender has.");

        bytes memory attackerHand = hands[attackerAddress];

        CardValue cardValue = getCardValue(deckSize, cards[0]);

        for (uint i = 0; i < cards.length; i++) {
            require(contains(attackerHand, cards[i]), "Card does not belong to attacker.");
            for (uint j = i + 1; j < cards.length; j++) {
                require(cards[j] != cards[i], "Duplicate cards.");
            }
            require(getCardValue(deckSize, cards[i]) == cardValue, "Combination of cards is not allowed. All cards in first attack must have the same value.");
        }
        
        attackCards = cards;
        hands[attackerAddress] = "";

        for (uint i = 0; i < attackerHand.length; i++) {
            if (!contains(cards, attackerHand[i])) hands[attackerAddress].push(attackerHand[i]);
        }
        // TODO if out of cards - win

        state = GameState.DEFEND;
    }


    // FOR TESTS

    function getAttackerAddress() public view returns (address) {
        return players[getAttackerIndex()];
    }

    function getAttackerHand() public view returns (bytes memory) {
        // cheaper ??
        address attackerAddress = getAttackerAddress();
        return hands[attackerAddress];
    }

    function addCard(address playerAddress, bytes1 card) public {
        hands[playerAddress].push(card);
    }
}
