// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract NFTmarket is ReentrancyGuard{
    // congrats listing your NFT is free in this Marketplace
    uint256 track=0;

    IERC20 public tokenAddress;
    constructor(address tokenERC20Address){
            tokenAddress=IERC20(tokenERC20Address);
    }


    struct Item{
        uint256 itemID;
        address nftcontract;         //address at which the nft is deployed
        uint256 tokenID;
        address seller;
        address owner;
        uint256 price;
        bool isSold;
    }
    //we can also emit the event in case for listening from our smart contract since we are not dealing 
    //with frontend and backened i haven't used it

    mapping(uint256=>Item) private uniqueIDforItem;

    

    function listYourNFT(address _nftContract, uint256 _tokenID ,uint256 _price) public nonReentrant{
        
        track++;
        uniqueIDforItem[track]=Item(track,_nftContract,_tokenID,
                                    msg.sender,address(0),_price,false);

        IERC721(_nftContract).transferFrom(msg.sender,address(this),_tokenID);                         

    }

    function buyListedNFT(address nftcontract, uint256 _track) public nonReentrant{
        require(_track>0 && _track<=track," No such item exist");
        uint256 price = uniqueIDforItem[_track].price;
        uint256 tokenID= uniqueIDforItem[_track].tokenID;
        tokenAddress.transferFrom(msg.sender,address(this),price);
        IERC721(nftcontract).transferFrom(address(this),msg.sender,tokenID);
        uniqueIDforItem[_track].isSold=true;
        uniqueIDforItem[_track].owner=msg.sender;

    }


}