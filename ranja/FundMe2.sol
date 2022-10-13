// SPDX-License-Identifier: MIT

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

pragma solidity ^0.8.8;


contract FundMe{
    uint256 public minimumUSD = 50 * 1e18;
    address[] public funders;
    mapping(address => uint256) public addressToAmoutFunded;
    ////GoerliEth/USD Address::0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
    function fund() public payable{    
        require(getConversionRate(msg.value) >= minimumUSD, "You need to spend more Ethereum!");
        addressToAmoutFunded[msg.sender] += msg.value;
        funders.push(msg.sender);

    }
    function getVersion() public view returns(uint256){
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        return priceFeed.version();
    }
    function getPrice() public view returns(uint256){
        //GoerliEth/USD Address::0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0xD4a33860578De61DBAbDc8BFdb98FD742fA7028e);
        (,int256 price,,,) = priceFeed.latestRoundData();
        //Eth/USD rate in 18 digit
        return uint256(price * 1e10);

    }
    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUSD = (ethPrice * ethAmount)/1e18;
        return ethAmountInUSD;
    }

}