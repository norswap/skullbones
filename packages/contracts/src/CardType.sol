// SPDX-License-Identifier: BSD-3-Clause-Clear
pragma solidity ^0.8.0;

import "openzeppelin/token/ERC721/ERC721.sol";
import "openzeppelin/access/Ownable.sol";

// NFT of CardType. Once you mint a card you get a new id
struct Card {
    CardType cardType;
    uint256 id; // 1,2,3,4,5...
}

// ERC721 keeps a mapping of _owners
contract CardType is ERC721, Ownable {
    uint256 nextId = 0;

    constructor (string memory name_) ERC721(name_, name_) {}

    function mint(address to) external onlyOwner {
        _safeMint(to, nextId++);
    }
}