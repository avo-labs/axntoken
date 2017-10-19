/// @title Aexon Crowdale Contract
/// @author Fleur Arkesteijn
pragma solidity ^ 0.4.18

import "github.com/OpenZeppelin/zeppelin-solidity/contracts/math/SafeMath.sol"

contract Crowdsale {
    using SafeMath for uint256; 
    
  address public gravitasWallet;
  uint public minimumGoal = 30000; 
  uint public fundingGoal = 1500015;
  uint public amountRaised = 0; 
  uint public constant price= 330; // 1 ether buys 330 tokens at moment of initialisation
  
  // amountRaised in ETH decides bonuscap
  uint public firstBonusCap = 30000; 
  uint public secondBonusCap = 90000; 
  uint public thirdBonusCap = 120000; 
  uint public fourthBonusCap = 180000; 
  uint public fifthBonusCap = 240000; 
 
  //start day+time for every bonusweek 
  // note: we are aware that now returns the blocktime , so that people who have aplied earlier might not get in on the bonus. 
  // to ensure you'll get in on the right bonusstructure, we urge you to apply in time. 
  uint public firstweek = 1512727200; //Fri, 08 Dec 2017 10:00:00 +0000 > 8 dec 2017 10:00 GMT 
  uint public secondWeek = 1513332000; // Fri, 15 dec 2017 10:00 
  uint public thirdWeek = 1513936800; //fri 22
  uint public fourthWeek= 1514541600; //fr 29
  uint public fifthWeek = 1515146400; // fr 5 jan 2018
  uint public afterFifthWeek = 1515751200 ; // 12 jan '18
  uint public closingDate = 1516579199 // Sun, 21 Jan 2018 23:59:59 +0000 
  
  int8 rate1 = 100;
  int8 rate2 = 75; 
  int8 rate3 = 50; 
  int8 rate4 = 25; 
  int8 rate5 = 10; 
  int8 rate6 = 0; //
  event fundingGoalReached(address gravitasWallet, uint amountRaised);
  event FundTransfer(address backer, uint amount, bool isContribution);
  
    uint tokens = msg.value.mul(PRICE); // 1 ether buys 330 axn at moment of writing contract

 
uint bonusPercentage = SafeMath.add(100, rate(amountRaised));

    if(rate==rate1) {tokens = token * 2;} //honderd percent bonus == tokens o.g. * 2
    if (rate == rate6){tokens=tokens}; // no bonus added
    else if (bonusPercentage != 100 &&rate !=rate6) {
      tokens = tokens.mul(percent(bonusPercentage)).div(percent(100)); 
    }
    
  
  function percent(uint256 p) internal returns (uint256) {
    return p.mul(10**16);
  }
  
  
function rate(uint bonusCap) returns uint {
    if(now > week5 || bonusCap > 240000){ 
	rate = rate6;}
else if (now >=week4 || bonusCap > 180000){
	rate = rate5;}
else if (now >=week3 || BonusCap > 120000){
    rate = rate4;}
else if (now >=week2 || BonusCap > 90000){
    rate = rate3;}
else if (now >=week1 || BonusCap > 30030){ 
    rate = rate2;}
else ()()
    rate = rate1; }
 }
 

 
}
