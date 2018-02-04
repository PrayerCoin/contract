pragma solidity ^0.4.18;

import "./PrayerCoinToken.sol";
import "./SafeMath.sol";

contract Standard {
    function balanceOf(address _owner) public constant returns (uint256);
    function transfer(address _to, uint256 _value) public returns (bool);
}

contract PrayerCoin is PrayerCoinToken {
  using SafeMath for uint256;
  address public god;

  string public name = "PrayerCoin";
  uint8 public decimals = 18;
  string public symbol = "PRAY";
  string public version = 'H1.0';  

  uint256 public publicSupply = 666666666 ether;
 
  uint private PRAY_ETH_RATIO = 6666;
  uint private PRAY_ETH_RATIO_BONUS1 = 7106;
  uint private PRAY_ETH_RATIO_BONUS2 = 11066;

  uint256 public totalDonations = 0;
  uint256 public totalPrayers = 0;

  bool private acceptingDonations = true;
  
  modifier divine {
    require(msg.sender == god);
    _;
  }

  function PrayerCoin() public { // initialize contract
    god = msg.sender;
    balances[god] = publicSupply; // god holds all of the PRAY
  } 

  function approveAndCall(address _spender, uint256 _value, bytes _extraData) public returns (bool success) {
    allowed[msg.sender][_spender] = _value;
    Approval(msg.sender, _spender, _value);

    //call the receiveApproval function on the contract you want to be notified. This crafts the function signature manually so one doesn't have to include a contract in here just for this.
    //receiveApproval(address _from, uint256 _value, address _tokenContract, bytes _extraData)
    //it is assumed that when does this that the call *should* succeed, otherwise one would use vanilla approve instead.
    require(false == _spender.call(bytes4(bytes32(keccak256("receiveApproval(address,uint256,address,bytes)"))), msg.sender, _value, this, _extraData));
    return true;
  } 

  function startDonations() public divine {
    acceptingDonations = true;
  }

  function endDonations() public divine {
    acceptingDonations = false;
  }

  function fiatSend(address _to, uint256 amt, uint256 prayRatio) public divine {
    totalDonations += amt;
    uint256 prayersIssued = amt.mul(prayRatio);
    totalPrayers += prayersIssued;
    balances[_to] += prayersIssued;
    balances[god] -= prayersIssued;

    Transfer(address(this), _to, prayersIssued);
  }

  function() public payable {
    require(acceptingDonations == true);
    if (msg.value == 0) { return; }

    god.transfer(msg.value);

    totalDonations += msg.value;
    
    uint256 prayersIssued = 0;

    if (totalPrayers <= (6666666 * 1 ether)) {
        if (totalPrayers <= (666666 * 1 ether)) {
            prayersIssued = msg.value.mul(PRAY_ETH_RATIO_BONUS2);
        } else {
            prayersIssued = msg.value.mul(PRAY_ETH_RATIO_BONUS1);
        }
    } else {
        prayersIssued = msg.value.mul(PRAY_ETH_RATIO);
    }

    totalPrayers += prayersIssued;
    balances[msg.sender] += prayersIssued;
    balances[god] -= prayersIssued;

    Transfer(address(this), msg.sender, prayersIssued);
  }
 
}
