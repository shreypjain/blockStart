pragma solidity ^0.6.9;

contract Shrey {
address owner;
uint fortune;
bool isDeceased;

constructor() public payable {
    owner = msg.sender;
    fortune = msg.value;
    isDeceased = false;
}
modifier onlyOwner {
    require (msg.sender == owner);
    _;
}
modifier mustBeDeceased {
    require(isDeceased == true);
    _;
}
address payable[] familyWallets;

mapping (address => uint) inheritance;

function setInheritance(address payable wallet, uint inheritAmount) public onlyOwner {
    familyWallets.push(wallet);
    inheritance[wallet] = inheritAmount;
}
function payout() private mustBeDeceased {
   for (uint i=0; i<familyWallets.length; i++) {
       familyWallets[i].transfer(inheritance[familyWallets[i]]);
   } 
}
function deceased() public onlyOwner {
    isDeceased = true;
    payout();
}
}
//need to migrate to an ethereum network using truffle, install truffle
//private ethereum network using ganache
//truffle providec cli, to get queries
//metamask-plugin for chrome to keep track of different ethereum accounts
