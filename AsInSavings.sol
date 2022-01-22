// SPDX-License-Identifier: MIT
pragma solidity ^0.5.0;

/*To create our solidity smart contract for our joint saving account we have got idea from a available code from 
online developed by "jasonjgarcia24" which also available on github repositories. Here we will also going to mention 
the link : https://github.com/jasonjgarcia24/ethereum-joint-savings-account/blob/main/contracts/joint_savings.sol
*/

/*Our Joint Savings Account Smart Contract will be deployed by named 'AsInSavings' and that will allowed two account
holders who will be able to control the savings account inorder to deposit, withdraw or to check any trnasactions.  
*/
contract AsInSavings {

    address payable accHolderOne;  //0x3B2eedA9d7f5f742385C18E86332bFB8f45acb1e
    address payable accHolderTwo;  //0x6d7700109340DFa1190dF5200F1f2B94E20aa7aF
    address public lastWithdrawFor;
    uint256 public lastWithdrawalAmount;
    uint256 public accBalance;

    function setAccounts(address payable Asif, address payable Ines) public{
        //here we can set our account address.
        setPrimaryAccount(Asif);
        accHolderTwo = Ines;
    }

    function setPrimaryAccount (address payable Asif) public{
        //to set a primary account for avoiding future hastle.
        accHolderOne = Asif;
    }

    function withdraw(uint256 _amount, address payable _recipient) public {
        //to withdraw any amount by one of the account holders.
        
        require(_recipient == accHolderOne || _recipient == accHolderTwo, "You don't own this account!");
        //to implement the withdraw function the first requirment is the recipient must be one of the account holder

        require(_recipient != address(0), "Address isn't valid.");
        //and reciepient account cannot be zero account

        require(_amount <= accBalance, "Insufficient funds!");
        //and the withdrawal amount cannot more than the total account Balance

        if (lastWithdrawFor != _recipient)
            lastWithdrawFor = _recipient;

        _recipient.transfer(_amount);
        
        lastWithdrawalAmount = _amount;
        accBalance = address(this).balance;
    }

    function deposit() public payable {
        //need to call this function to deposit balance in our account.
        require(accHolderOne != address(0), "Need to set a primary account first.");
        
        //let's deposit the amount to our accBalance by declaring 'this' address
        accBalance = address(this).balance;
    }

    function () external payable {}
        //this will help us to store Ether sent from outside the deposit function.
}
