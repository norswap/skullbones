// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "openzeppelin/token/ERC721/ERC721.sol";

struct Card {
    CardType cardType;
    uint256 id;
}

contract CardType is ERC721 {
    constructor (string memory name_) ERC721(name_, name_) {}
}