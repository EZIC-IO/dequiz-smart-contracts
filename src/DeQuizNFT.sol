// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

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
    uint256 public constant MAX_SUPPLY = 1000;
    uint256 public constant MINT_PRICE = 0.000_111 ether;

    uint256 private _tokenIdCounter;
    string private _contractMetadataURI;

    mapping(address => uint256) private _tokenIdOwnership;

    constructor(string memory name, string memory symbol, address initialOwner, string memory contractMetadataURI)
        ERC721(name, symbol)
        Ownable(initialOwner)
    {
        // >> "deleted" values return to their default value, which is 0 for numbers;
        // >> Start counting from 1 to avoid security risks as suggested by Base Camp
        _tokenIdCounter = 1;
        _contractMetadataURI = contractMetadataURI;
    }

    function safeMint(string memory uri) public payable {
        // >> Validate that max supply is not reached
        if (_tokenIdCounter > MAX_SUPPLY) revert MaxSupplyExceeded();
        // >> Limit to 1 per wallet
        if (balanceOf(msg.sender) > 0) revert MaxAmountPerWalletExceeded();
        // >> Mint Price
        if (msg.value != MINT_PRICE) revert InsufficientValueForMintFee(MINT_PRICE);
        _safeMint(msg.sender, _tokenIdCounter);
        _setTokenURI(_tokenIdCounter, uri);
        // >> Record ownership of token ID
        _tokenIdOwnership[msg.sender] = _tokenIdCounter;
        // >> Emit event to inform application that the mint was successful
        emit MintSuccessful(msg.sender, _tokenIdCounter);
        // >> Increment tokenId counter
        _tokenIdCounter++;
    }

    // >> OpenSea Collection Metadata
    function contractURI() public view returns (string memory) {
        return _contractMetadataURI;
    }

    // >> The following functions are overrides required by Solidity
    function tokenURI(uint256 tokenId) public view override(ERC721, ERC721URIStorage) returns (string memory) {
        return super.tokenURI(tokenId);
    }

    function supportsInterface(bytes4 interfaceId) public view override(ERC721, ERC721URIStorage) returns (bool) {
        return super.supportsInterface(interfaceId);
    }

    // >> Custom read convenience functions
    function alreadyMintedGlobalAmount() public view returns (uint256) {
        return _tokenIdCounter - 1;
    }

    function ownedTokenId(address addr) public view returns (uint256) {
        return _tokenIdOwnership[addr];
    }

    function totalSupply() public pure returns (uint256) {
        return MAX_SUPPLY;
    }

    function canInitiateMint(address addr) public view returns (bool) {
        return (_tokenIdCounter < MAX_SUPPLY && balanceOf(addr) == 0);
    }

    // >> Owner functions
    function withdrawETH() public onlyOwner {
        address payable to = payable(owner());
        to.transfer(address(this).balance);
    }

    event MintSuccessful(address indexed _from, uint256 _tokenId);

    error MaxSupplyExceeded();
    error InsufficientValueForMintFee(uint256 _mintPrice);
    error MaxAmountPerWalletExceeded();
}
