var PhotoNFTFactory = artifacts.require("PhotoNFTFactory");

module.exports = function(deployer) {
  // deployment steps
  deployer.deploy(PhotoNFTFactory);
};