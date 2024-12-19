async function main() {
    const [deployer] = await ethers.getSigners();
    console.log("Deploying contracts with the account:", deployer.address);

    const MarketplaceNFT = await ethers.getContractFactory("MarketplaceNFT");
    const nftContract = await MarketplaceNFT.deploy();
    console.log("NFT contract deployed to:", nftContract.address);

    // Optionally, you can mint an NFT right after deploying the contract
    const tokenURI = "ipfs://QmSomeTokenURI";
    await nftContract.mintNFT(deployer.address, tokenURI);
    console.log("NFT minted with tokenId 1 and URI:", tokenURI);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
