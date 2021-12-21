contract Bank {

    // mapping

    mapping (address => uint) account_balance;


    //get_balance()
    function get_balance() external view returns (uint){
        return account_balance[msg.sender];
    }
    //transfer
    function transfer(address recipient, uint amount) public{
        account_balance[msg.sender] -= amount;
        account_balance[recipient] += amount;
    }
    //withdraw
    function withdraw(uint amount) public{
        account_balance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);

    }
    //receive
    receive () external payable {
        account_balance[msg.sender] += msg.value;
    }
}

contract Bank_ext{
     
     uint number_of_account;  // number_of_account
    
    mapping (address => uint) account_balance;
    mapping (address => uint) account_info_map;
 
 
 struct BankAccountRecord{
        uint account_number;
        string fullName;
        string profession;
        string DataOfBrith;
        address wallet_addr;
        string Customer_addr;
 }
        BankAccountRecord [] BankAccountRecords;

        // method of register_account
    function register_account(
            string memory fullName_,
            string memory profession_,
            string memory DataOfBrith_,
            string memory Customer_addr_) external {
        
            require(account_info_map[msg.sender] == 0,"Account already registered.");

            BankAccountRecords.push(
                BankAccountRecord({
                    account_number:++number_of_account,
                    fullName:fullName_,
                    profession:profession_,
                    DataOfBrith:DataOfBrith_,
                    wallet_addr:msg.sender,
                    Customer_addr:Customer_addr_
                }));

                account_info_map[msg.sender] = number_of_account;
                }

                //
      modifier onlyRegistered() {
         require(account_info_map[msg.sender] > 0 , "User NOT Register");
         _;
    }
        // method of get_balance()
    function get_balance() external view onlyRegistered returns (uint){
        return account_balance[msg.sender];
    }
     // method of transfer
    function transfer(address recipient, uint amount) public onlyRegistered{
        account_balance[msg.sender] -= amount;
        account_balance[recipient] += amount;
    }
    // method of withdraw
    function withdraw(uint amount) public onlyRegistered{
        account_balance[msg.sender] -= amount;
        payable(msg.sender).transfer(amount);
    }

    receive () external payable {
        account_balance[msg.sender] += msg.value;
    }

} 
