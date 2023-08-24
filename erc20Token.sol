// SPDX-License-Identifier: MIT
pragma solidity ^0.8.1;

contract DMZ {

 string name;
 string symbol;
 uint constant DECIMAL = 18;
 uint totalSupply;

 mapping(address => uint)_balance;
 mapping(address => mapping(address => uint)) _allowance;

 constructor(string memory _name, string memory _symbol) {
     name = _name;
     symbol = _symbol;
 }

 function getname() public view returns(string memory) {
     return name;
 }

 function getSymbol() public view returns(string memory) {
     return symbol;
 }

 function getDecimal() public pure returns(uint) {
     return DECIMAL;
 }

 function getTotalSupply() public view returns(uint) {
     return totalSupply;
 }

 function balanceOf(address _owner) public view returns (uint balance) {
     return _balance[_owner];
 }

 function transfer(address _to, uint _value) external returns(bool success) {
     require(_to != address(0), "can't send to a zero address");
     require(_value > 0, "Amount too low");
     require(balanceOf(msg.sender) >= _value,"Insufficient balance");
     _balance[msg.sender] -= _value;
     _balance[_to] += _value;
     success = true;
 }

 function transferFrom(address _from, address _to, uint _value) external returns(bool success) {
      require(_to != address(0), "can't send to a zero address");
     require(_value > 0, "Amount too low");
     require(balanceOf(_from) >= _value,"Insufficient balance");
     _balance[_from] -= _value;
     _balance[_to] += _value;
     success = true;
 }

 function approve(address _spender, uint _value) public returns(bool success) {
     _allowance[msg.sender][_spender] = _value;
     success = true;
 }

 function allowance(address _owner, address _spender) public view returns(uint) {
     return _allowance[_owner][_spender];
 }

 function mint(address _to, uint _value) public {
     require(_to != address(0), "invalid address");
     _balance[msg.sender]  += _value;
     totalSupply += _value;
 }

 function burn(uint _value) public {
     require(balanceOf(msg.sender) >= _value, "Insufficient balance");
     _balance[msg.sender] -= _value;
     totalSupply -= _value;

 }

    // ... (existing code)

   /* function withdraw(uint _amount) public {
        require(_balance[msg.sender] >= _amount, "Insufficient balance");
        _balance[msg.sender] -= _amount;
        payable(msg.sender).transfer(_amount);
    }*/

    // ... (existing code)

    function mint(address _to) public payable {
        require(_to != address(0), "invalid address");
        require(msg.value >= 5 ether, "Ether sent is less than 5");

        uint _value = 1; // Mint 1 token

        _balance[_to] += _value;
        totalSupply += _value;
    }

}





