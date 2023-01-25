// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;
pragma experimental ABIEncoderV2;


import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import  "./PhotoNFT.sol";

/**
 * @notice - This is the factory contract for a NFT of photo
 */
contract PhotoNFTFactory {
    using SafeMath for uint256;
    using Strings for string;

    address[] public photoAddresses;
    event PhotoNFTCreated (
        address owner,
        PhotoNFT photoNFT,
        string nftName, 
        string nftSymbol, 
        string ipfsHashOfPhoto
    );
    
    function createNewPhotoNFT(
        string memory nftName,
        string memory nftSymbol,
        string memory ipfsHashOfPhoto,
        uint256 maxSupply
    ) public returns (address) {
        
        /// [Note]: Initial owner of photoNFT is msg.sender
        address owner = msg.sender; 
        string memory tokenURI = getTokenURI(ipfsHashOfPhoto); /// [Note]: IPFS hash + URL
        PhotoNFT photoNFT =
            new PhotoNFT(
                owner,
                nftName,
                nftSymbol,
                tokenURI,
                maxSupply
            );
        photoAddresses.push(address(photoNFT));

        emit PhotoNFTCreated(
            msg.sender,
            photoNFT,
            nftName,
            nftSymbol,
            ipfsHashOfPhoto
        );
        return address(photoNFT);
    }

    ///-----------------
    /// Getter methods
    ///-----------------
    function baseTokenURI() public pure returns (string memory) {
        return "https://ipfs.io/ipfs/";
    }

    function getTokenURI(string memory _ipfsHashOfPhoto)
        public
        pure
        returns (string memory)
    {
        string memory _url = baseTokenURI();
        return  string.concat( _url, _ipfsHashOfPhoto);
    }
}
