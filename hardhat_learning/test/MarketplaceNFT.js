const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("MarketplaceNFT", function () {
  let nftContract;
  let owner, addr1, addr2;

  beforeEach(async function () {

    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    const MarketplaceNFT = await ethers.getContractFactory("MarketplaceNFT");
    const nftContract = await MarketplaceNFT.deploy();
    console.log("NFT contract deployed to:", nftContract.address);
    
  });

  it("Should deploy the contract and mint an NFT", async function () {
    const tokenURI = "ipfs://QmExampleTokenURI";
    const tx = await nftContract.mintNFT(addr1.address, tokenURI);
    const receipt = await tx.wait();

    const tokenId = 1;
    expect(await nftContract.ownerOf(tokenId)).to.equal(addr1.address);
    expect(await nftContract.tokenURI(tokenId)).to.equal(tokenURI);
  });

  it("Should set and get price for an NFT", async function () {
    const tokenURI = "ipfs://QmExampleTokenURI";
    await nftContract.mintNFT(addr1.address, tokenURI);

    const tokenId = 1;
    const price = ethers.utils.parseEther("1.0");

    await nftContract.connect(addr1).setPrice(tokenId, price);
    expect(await nftContract.prices(tokenId)).to.equal(price);
  });

  it("Should allow buying an NFT", async function () {
    const tokenURI = "ipfs://QmExampleTokenURI";
    await nftContract.mintNFT(addr1.address, tokenURI);

    const tokenId = 1;
    const price = ethers.utils.parseEther("1.0");
    await nftContract.connect(addr1).setPrice(tokenId, price);

    await expect(() =>
      nftContract.connect(addr2).buyNFT(tokenId, { value: price })
    ).to.changeEtherBalances([addr1, addr2], [price, -price]);

    expect(await nftContract.ownerOf(tokenId)).to.equal(addr2.address);
  });
});
