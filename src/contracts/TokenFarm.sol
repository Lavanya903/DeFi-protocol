pragma solidity ^0.5.0;
import "./DappToken.sol";
import "./DaiToken.sol";
contract TokenFarm {
    //all code goes here..
    string public name="Dapp token farm";
    //stake variable stored on block chain
    DappToken public dappToken;//DappToken is type 
    DaiToken public daiToken;
    address public owner;
    address[] public stakers;
    mapping(address=> uint)public stakingBalance;
    mapping(address=>bool)public hasStaked;
    mapping(address=>bool)public isStaking;


    constructor(DappToken _dappToken,DaiToken _daiToken) public {
        //store reference to DaiTokenand DappToken,address
        dappToken=_dappToken;
        daiToken= _daiToken;
        owner=msg.sender;
    }
    //1.stakes tokens(deposit)
    function stakeTokens(uint _amount)public {
        //require amount greater than 0
        require(_amount >0 ,"amount cannot be 0");
        //trsnsfer mock dai tokent to contract for staking
        daiToken.transferFrom(msg.sender,address(this),_amount);
        stakingBalance[msg.sender]=stakingBalance[msg.sender]+_amount;
       
      
        //add user to stakers array only if they havents stakedalready
          if(!hasStaked[msg.sender]){
             stakers.push(msg.sender);
        }
        isStaking[msg.sender]=true;
        hasStaked[msg.sender]=true;
    }
    //2.Unstake tokens(withdraw)
    function unstakeTokens() public {
        //fetch staking balance
        uint balance=stakingBalance[msg.sender];
        //require amount greater than 0
        require(balance>0,"staking balance cannot be 0");
        //Transfer Mock Dai tokens to this ontracr for staking
        daiToken.transfer(msg.sender,balance);
        //reset staking balance
        stakingBalance[msg.sender]=0;
        isStaking[msg.sender]=false;
    }

    //3.Issuing Tokens(interset)
    function issueTokens() public {
        require(msg.sender==owner,"caller must be the owner");
        //issue tokens to all stakers
        for (uint i=0;i<stakers.length;i++){
            address recipient=stakers[i];
            uint balance=stakingBalance[recipient];
            if(balance>0){
                dappToken.transfer(recipient,balance);
            }
            
        }
    }
}