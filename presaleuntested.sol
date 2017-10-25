import '../math/SafeMath.sol';

contract Crowdsale {
  using SafeMath for uint256;

  // The token being sold
  MintableToken public token;

  // start and end timestamps where investments are allowed (both inclusive)
  uint256 public startTime;
  uint256 public endTime;

  // address where funds are collected
  address public wallet = 0x1645a5E53be1E1969cAFdf6aeDBDac6df893DA6B; // Fleurs address. 

  // how many token units a buyer gets per wei
  uint256 public rate = 390; //30%
  
  // minimum purchase is half a token. 
  uint256 public minPurchaseAmount= 333333333333333333; // one dollar worth of wei 
  // amount of raised money in wei
  uint256 public weiRaised;

  /**
   * event for token purchase logging
   * @param purchaser who paid for the tokens
   * @param beneficiary who got the tokens / fleur
   * @param value weis paid for purchase 
   * @param amount amount of tokens purchased
   */
  event TokenPurchase(address indexed purchaser, address indexed beneficiary, uint256 value, uint256 amount);


  function presale(uint256 _startTime, uint256 _endTime, uint256 _rate, address _wallet) {
    require(_startTime >= now);
    require(_endTime >= _startTime);
    require(_rate > 0);
     require(_rate > 0);
    require(_wallet != address(0));

    token = createTokenContract();
    startTime = _startTime;
    endTime = _endTime;
    rate = _rate ;
    wallet = _wallet;
  }

  // creates the token to be sold.
  // override this method to have crowdsale of a specific mintable token.
  function createTokenContract() internal returns (MintableToken) {
    return new MintableToken();
  }


  // fallback function can be used to buy tokens
  function () payable {
    buyTokens(msg.sender);
  }

  // low level token purchase function
  function buyTokens(address beneficiary) public payable {
    require(beneficiary != address(0));
    require(validPurchase());
    uint256 time = now;

//to do: because it raises per day with 15 exactly, use for loop. 

    uint256 weiAmount = msg.value;
    if(time >= (startTime + 7 days) && weiRaised < 240000 ether)
    {rate = 315;} //5%
    if (time >= (startTime + 5 days) && weiRaised < 180000 ether)
    {rate = 330;} //10%
    if (time >= (startTime + 4 days) && weiRaised <  120000 ether)
    {rate = 345;} //15%
     if (time >= (startTime + 3 days) && weiRaised< 90000 ether)
    {rate = 360;} //20%
    if (time >= (startTime + 2 days) && weiRaised < 60600 ether)
    {rate = 375;} //25%
    if (time >= startTime && weiRaised < 30300 ether)
    {rate = 390;} //30%
    
    
    
    // calculate token amount to be created
    uint256 tokens = weiAmount.mul(rate);

    // update state
    weiRaised = weiRaised.add(weiAmount);

    token.mint(beneficiary, tokens);
    TokenPurchase(msg.sender, beneficiary, weiAmount, tokens);

    forwardFunds();
  }

  // send ether to the fund collection wallet
  // override to create custom fund forwarding mechanisms
  function forwardFunds() internal {
    wallet.transfer(msg.value);
  }

  // @return true if the transaction can buy tokens
  function validPurchase() internal constant returns (bool) {
    bool withinPeriod = now >= startTime && now <= endTime;
    bool nonZeroPurchase = msg.value != 0;
    bool minPurchaseAmountOk = msg.value > minPurchaseAmount
    return withinPeriod && nonZeroPurchase && minPurchaseAmountOk;
  }

  // @return true if crowdsale event has ended
  function hasEnded() public constant returns (bool) {
    return now > endTime;
  }
}