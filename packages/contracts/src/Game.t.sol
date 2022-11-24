pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Game.sol";
import "./Player.sol";

contract GameTest is Test {
    function testConstructor() public {
        Player a = new Player();
        Player b = new Player();
        new Game(a, b);
    }
}
