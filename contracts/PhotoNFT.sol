// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
/**
 * @notice - This is the NFT contract for a photo
 */
contract PhotoNFT is IERC721Metadata, ERC721  {
    using SafeMath for uint256;
    string private baseURI;
    uint256 public currentPhotoId = 0;

    constructor(
        address owner, /// Initial owner (Seller)
        string memory _nftName,
        string memory _nftSymbol,
        string memory _tokenURI, /// [Note]: TokenURI is URL include ipfs hash
        uint256 mintSupply
    ) ERC721(_nftName, _nftSymbol) {
        setBaseURI(_tokenURI);
        mint(owner, mintSupply);
        
    }

    /**
     * @dev mint a photoNFT
     * @dev tokenURI - URL include ipfs hash
     */
    function mint(
        address to,
        uint256 mintSupply
    ) public returns (bool) {
        /// Mint a new PhotoNFT
        for (uint256 i = currentPhotoId + 1; i <= mintSupply; i++) {
            currentPhotoId++;
            _mint(to, i);
        }
        return true;
    }

    function _baseURI() internal view override returns (string memory) {
        return baseURI;
    }

    function setBaseURI(string memory _newBaseURI) public returns(bool) {
        baseURI = _newBaseURI;
        return true;
    }
}
