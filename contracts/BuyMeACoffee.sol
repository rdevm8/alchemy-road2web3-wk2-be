// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";

error BuyMeACoffee__DidNotTipEnough();
error BuyMeACoffee__WithdrawFailed();

contract BuyMeACoffee is Ownable {
    event NewMemo(address indexed from, uint256 timeStamp, string name, string message);

    struct Memo {
        address from;
        uint256 timeStamp;
        string name;
        string message;
    }

    uint256 private immutable i_minTip;
    address payable private s_withdrawalAddress;
    Memo[] private s_memos;

    constructor(uint256 minTip) {
        i_minTip = minTip;
        s_withdrawalAddress = payable(msg.sender);
    }

    function buyCoffee(string memory name, string memory message) public payable {
        if (msg.value < i_minTip) {
            revert BuyMeACoffee__DidNotTipEnough();
        }

        s_memos.push(Memo(msg.sender, block.timestamp, name, message));

        emit NewMemo(msg.sender, block.timestamp, name, message);
    }

    function withdraw() public onlyOwner {
        uint256 amount = address(this).balance;

        (bool success, ) = s_withdrawalAddress.call{ value: amount }("");

        if (!success) {
            revert BuyMeACoffee__WithdrawFailed();
        }
    }

    function setWithdrawalAddress(address newWithdrawalAddress) public {
        s_withdrawalAddress = payable(newWithdrawalAddress);
    }

    function getMemos() public view returns (Memo[] memory) {
        return s_memos;
    }

    function getMinTip() public view returns (uint256) {
        return i_minTip;
    }

    function getWithdrawalAddress() public view returns (address) {
        return s_withdrawalAddress;
    }
}
