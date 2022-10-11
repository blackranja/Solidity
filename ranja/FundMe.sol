//   SPDX-Lincense-Identifier : MIT
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
pragma solidity ^0.8.7;
contract FundMe{

uint public minimumUsd = 50;
function fund() public payable{
    require(msg.value >= minimumUsd, "Spend more Ethes");
}
function getPrice() public{
    //ABI
    //Address:0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
}
function getVersion() public view returns(uint256){
    //ABI
    //Address:0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
    AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
    return priceFeed.version();

}
}