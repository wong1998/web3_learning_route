// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MarketplaceNFT is ERC721URIStorage, Ownable {
    uint256 private _tokenIds; // 用于记录当前的 Token ID
    mapping(uint256 => uint256) public prices; // 存储每个 NFT 的价格

    event NFTMinted(address indexed creator, uint256 indexed tokenId, string tokenURI);
    event NFTPriceSet(uint256 indexed tokenId, uint256 price);

    // 构造函数：初始化 ERC721 和 Ownable
    constructor() ERC721("MarketplaceNFT", "MPNFT") Ownable(msg.sender) {}

    /**
     * @dev 铸造 NFT
     * @param recipient NFT 的接收者地址
     * @param tokenURI  NFT 的元数据 URI (例如指向 IPFS)
     * @return tokenId 返回新铸造的 Token ID
     */
    function mintNFT(address recipient, string memory tokenURI) external onlyOwner returns (uint256) {
        _tokenIds++; // 自增 Token ID
        uint256 newTokenId = _tokenIds;

        // 铸造 NFT 并设置 Token URI
        _mint(recipient, newTokenId);
        _setTokenURI(newTokenId, tokenURI);

        emit NFTMinted(recipient, newTokenId, tokenURI);
        return newTokenId;
    }

    /**
     * @dev 为 NFT 设置价格
     * @param tokenId NFT 的 Token ID
     * @param price   NFT 的价格 (以 Wei 为单位)
     */
    function setPrice(uint256 tokenId, uint256 price) external {
        require(ownerOf(tokenId) == msg.sender, "Only the owner can set the price");
        require(price > 0, "Price must be greater than 0");
        prices[tokenId] = price;

        emit NFTPriceSet(tokenId, price);
    }

    /**
     * @dev 获取 Token URI
     * @param tokenId NFT 的 Token ID
     * @return tokenURI 返回与该 Token ID 相关联的 URI
     */
    function getTokenURI(uint256 tokenId) external view returns (string memory) {
        return tokenURI(tokenId);
    }

    /**
     * @dev 购买 NFT
     * @param tokenId NFT 的 Token ID
     */
    function buyNFT(uint256 tokenId) external payable {
        address tokenOwner = ownerOf(tokenId);
        uint256 price = prices[tokenId];

        require(msg.value == price, "Incorrect price");
        require(tokenOwner != msg.sender, "You already own this NFT");

        // 转移 NFT 所有权
        _transfer(tokenOwner, msg.sender, tokenId);

        // 转移资金给卖家
        payable(tokenOwner).transfer(msg.value);

        // 重置价格
        prices[tokenId] = 0;
    }

    /**
     * @dev 重写 _baseURI 函数，设置基础 URI (用于拼接 tokenURI)
     */
    function _baseURI() internal pure override returns (string memory) {
        return "https://gateway.pinata.cloud/ipfs/";
    }
}
