pragma solidity ^0.8.0;

import "@openzeppelin/token/ERC721/ERC721.sol";
import {Card, CardType} from "./CardType.sol";
import "./Player.sol";
import "forge-std/console2.sol";

contract Game {

    struct PlayerSetup {
        Player player;
        uint256 deck;
        Card[] hand;
    }

    PlayerSetup[] players;

    constructor(Player a, Player b) {
        createPlayerSetup(players, a);
        createPlayerSetup(players, b);
    }

    function createPlayerSetup(Player player) private returns(uint256) {
        players.push();
        uint256 id = players.length - 1;
        players[id].player = player;
        players[id].deck = 0;
        return id;
    }
}
