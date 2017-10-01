pragma solidity ^0.4.13;

//Copyright Gravitas Holdings Pte Ltd. MIT License
//Author : @santoshrout

// Extended from @BokkyPooBah https://theethereum.wiki/w/index.php/ERC20_Token_Standard. Licence: MIT Licence.

contract ERC20Interface {

	// Get the total token supply
	function totalSupply() constant returns (uint256 totalSupply);
	 
	// Get the account balance of another account with address _address
	function balanceOf(address _address) constant returns (uint256 balance);
		
	// Send _value amount of tokens to address _to
	function transfer(address _to, uint256 _value) returns (bool success);
	  
	// Send _value amount of tokens from address _from to address _to
	function transferFrom(address _from, address _to, uint256 _value) returns (bool success);
	  
	// Allow _spender to withdraw from your account, multiple times, up to the _value amount.
	// If this function is called again it overwrites the current allowance with _value.
	// this function is required for some DEX functionality
	function approve(address _spender, uint256 _value) returns (bool success);
	 
	// Returns the amount which _spender is still allowed to withdraw from _owner
	function allowance(address _owner, address _spender) constant returns (uint256 remaining);
	 
	// Triggered when tokens are transferred.
	event Transfer(address indexed _from, address indexed _to, uint256 _value);
	 
	// Triggered whenever approve(address _spender, uint256 _value) is called.
	event Approval(address indexed _owner, address indexed _spender, uint256 _value);

}


contract AXNToken is ERC20Interface{
	string public constant symbol = "AEXON";  
	string public constant name = "AEXON Token";
	uint8 public constant decimals = 18;
	uint256 _totalSupply = 3000000000;
	
	//owner of this contract
	address public owner;
	
	//Balance of each account
	mapping(address => uint256) balances;
	
	
	mapping (address => mapping (address => uint256)) allowed;
	
	
	modifier onlyOwner(){
		require (msg.sender !=owner);
	}
	
	
	function AXNToken(){
		owner = msg.sender;
		balances[owner] = _totalSupply;
	}

	function totalSupply() constant returns (uint256 totalSupply) {
		totalSupply = _totalSupply;
	}
	
	function balanceOf(address _owner) constant returns (uint256 balance) {
		return balances[_owner];
	}
	
	
	/**
     * Internal transfer, only can be called by this contract
     */
    function _transfer(address _from, address _to, uint _value) internal {
        // Prevent transfer to 0x0 address. Use burn() instead
        require(_to != 0x0);
        // Check if the sender has enough
        require(balanceOf[_from] >= _value);
        // Check for overflows
        require(balanceOf[_to] + _value > balanceOf[_to]);
        // Save this for an assertion in the future
        uint previousBalances = balanceOf[_from] + balanceOf[_to];
        // Subtract from the sender
        balanceOf[_from] -= _value;
        // Add the same to the recipient
        balanceOf[_to] += _value;
        Transfer(_from, _to, _value);
        // Asserts are used to use static analysis to find bugs in your code. They should never fail
        assert(balanceOf[_from] + balanceOf[_to] == previousBalances);
    }

    /**
     * Transfer tokens
     *
     * Send `_value` tokens to `_to` from your account
     *
     * @param _to The address of the recipient
     * @param _value the amount to send
     */
    function transfer(address _to, uint256 _value) public {
        _transfer(msg.sender, _to, _value);
    }

    /**
     * Transfer tokens from other address
     *
     * Send `_value` tokens to `_to` in behalf of `_from`
     *
     * @param _from The address of the sender
     * @param _to The address of the recipient
     * @param _value the amount to send
     */
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool success) {
        require(_value <= allowance[_from][msg.sender]);     // Check allowance
        allowance[_from][msg.sender] -= _value;
        _transfer(_from, _to, _value);
        return true;
    }
}

