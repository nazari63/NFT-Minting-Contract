// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

interface IERC721 {
    function safeMint(address to, uint256 tokenId) external;
    function ownerOf(uint256 tokenId) external view returns (address);
}

contract NFTMinting {
    address public admin;
    uint256 public tokenCounter;
    address public nftContract;

    event NFTMinted(address indexed user, uint256 tokenId);

    constructor(address _nftContract) {
        admin = msg.sender;
        nftContract = _nftContract;
        tokenCounter = 0;
    }

    function mintNFT(address to) external {
        require(msg.sender == admin, "Only admin can mint NFTs");
        tokenCounter++;
        IERC721(nftContract).safeMint(to, tokenCounter);
        emit NFTMinted(to, tokenCounter);
    }

    function getNFTOwner(uint256 tokenId) external view returns (address) {
        return IERC721(nftContract).ownerOf(tokenId);
    }
}