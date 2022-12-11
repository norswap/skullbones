// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "openzeppelin/token/ERC721/ERC721.sol";
import {Card, CardType} from "./CardType.sol";
import "./Player.sol";
import "forge-std/console2.sol";

contract Game {

    struct PlayerSetup {
        Player player;
        // index of one of player's decks (playlists)
        uint256 deck;
        // what's on the table, player can play only cards in his hand
        Card[] hand;
    }

    // in order of play turn
    PlayerSetup[] players;
    // index in players - signifies whose turn it is
    uint8 turn;

    constructor(Player a, Player b) {
        createPlayerSetup(a);
        createPlayerSetup(b);
    }

    function createPlayerSetup(Player player) private returns(uint256) {
        players.push();
        uint256 id = players.length - 1;
        players[id].player = player;
        players[id].deck = 0;
        return id;
    }
}
