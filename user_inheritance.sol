// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract User{
    string public email;
    string public message;

    function set_content(string memory _email, string memory _message) public {
        email = _email;
        message = _message;
    } 
}

contract Tweet is User{
    string public platform_name1 = "Twitter";

    function get_app_name () public view returns (string memory, string memory, string memory){
        return (platform_name1, email, message);
    }
}

contract LinkedIn is User{
    string public platform_name2 = "LinkedIn";

    function get_app_detail () public view returns (string memory, string memory, string memory){
        return (platform_name2, email, message);
    }
}

contract All_data is Tweet,LinkedIn{
    
    function getAll_data() public view returns (string memory, string memory, string memory, string memory){
        return (platform_name1,platform_name2, email, message);
    }

}