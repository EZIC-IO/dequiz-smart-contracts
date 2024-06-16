// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

/// @author ezic.io

/* =============================
 _____ ________ ____   ___ ___  
| ____|__  /_ _/ ___| |_ _/ _ \ 
|  _|   / / | | |      | | | | |
| |___ / /_ | | |___ _ | | |_| |
|_____/____|___\____(_)___\___/ 
============================= */

import {ERC721} from "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import {ERC721URIStorage} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import {ERC721Burnable} from "@openzeppelin/contracts/token/ERC721/extensions/ERC721Burnable.sol";
import {Ownable} from "@openzeppelin/contracts/access/Ownable.sol";

contract DeQuizNFT is ERC721, ERC721URIStorage, ERC721Burnable, Ownable {
    uint256 private _tokenIdCounter;
    uint256 MAX_SUPPLY = 1_000; // Max supply is 1000;

    constructor(
        string memory name,
        string memory symbol,
        address initialOwner
    ) ERC721(name, symbol) Ownable(initialOwner) {
        // "deleted" values return to their default value, which is 0 for numbers;
        // Start counting from 1 to avoid security risks as suggested by Base Camp;
        _tokenIdCounter = 1;
    }

    function safeMint(uint256 tokenId, string memory uri) public {
        // Validate that max supply is not reached;
        require(_tokenIdCounter <= MAX_SUPPLY, "I'm sorry we reached the cap");
        // Limit to 1 per wallet
        require(balanceOf(msg.sender) == 0, "Max Mint per wallet reached");
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, uri);
        // Increment tokenId counter;
        _tokenIdCounter++;
    }

    // The following functions are overrides required by Solidity;
    function tokenURI(
        uint256 tokenId
    ) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(
        bytes4 interfaceId
    ) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }
}
