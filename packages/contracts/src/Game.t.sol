// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "forge-std/Test.sol";
import "./Game.sol";
import "./Player.sol";

contract GameTest is Test {

    function testConstructor() public {
        Game game = new Game();
        for (uint8 i = 1; i < 3; i++) {
            game.enterGame(vm.addr(i));
        }
        game.startGame(52);



        // vm.expectRevert(Game.SamePlayer.selector);
    }

    
}
