//SPDX-License-Identifier: GPL-3.0;
pragma solidity ^0.8.7;

contract LandRegistry{
  
             // ---------------- START STRUCT  ----------------- //
    struct landregistry
    {
    address Owner;
    string Area;
    string City;
    string State;
    uint LandPrice; 
    uint PropertyId;
    }

     struct BuyerDetails{

        string Name;
        uint Age;
        string City;
        uint Cnic;
        string Email;

    }

    struct SellerDetails{
        uint id;
        string Name;
        uint Age;
        string City;
        uint Cnic;
        string Email;
        
      
    }

    struct LandInspector{
        address id;
        string name;
        uint age;
        string designation;
    }
   

             // ---------------- STRUCT END ----------------- //


 


             // ----------------  MAPPING START ----------------- //
  
    mapping(uint => landregistry) public land;
    mapping(address=> BuyerDetails) public buyer;
    mapping(address => SellerDetails) public seller;
    mapping(address => LandInspector) public landInspector;
    mapping (address => bool) public VerifiedSeller;
    mapping(address => bool) public VerifiedBuyer;
    mapping (uint => bool) public VerifyLand;

             // ---------------- MAPPING END ----------------- //





             // ----------------  START LAND INSPECTOR FUNCTION ----------------- //

   function Landinspector(
   address _addr,
   string memory _name,
   uint _age,
   string memory _designation) public 
   {
       landInspector[msg.sender] = LandInspector(_addr,_name,_age,_designation);
   }
                // ----------------  END ----------------- //

     




             // ----------------  SELLER REGISTER FUNCTION ----------------- //

    function SellerRegister(uint _id,
    string memory _Name,
    uint _Age,
    string memory _City,
    uint _Cnic,
    string memory _Email) public {
        seller[msg.sender] = SellerDetails (_id,
        _Name,
        _Age,
        _City,
        _Cnic,
        _Email);
        VerifiedSeller[msg.sender] = false;
    }
             // ----------------  END ----------------- //
  




             // ----------------  SELLER VERIFY FUNCTION ----------------- //
      function SellerVerified(address _addr) public {
       VerifiedSeller[_addr] = true;
           }
 
             // ----------------  END  ----------------- //





             // ---------------- SELLER REJECT FUNCTION ----------------- //

           function SellerReject(address _addr) public  {
          VerifiedSeller[_addr] = false;
           }

             // ----------------  END  ----------------- //





             // ----------------  LAND REGISTER FUNCTION ----------------- //

      function LandRegister(uint _LandId, address, string memory _Area, string memory _City, string memory _State, uint _LandPrice, uint _PropertyId) public {
             land[_LandId] =landregistry(msg.sender, _Area, _City, _State, _LandPrice, _PropertyId);
             VerifyLand[_LandId] = false;
             
           }

             // ----------------  END  ----------------- //




             // ----------------  LAND VERIFY FUNCTION  ----------------- //

            function LandVerifying(uint _LandId) public {
          VerifyLand[_LandId] = true;
           }

             // ----------------  END  ----------------- //





             // ----------------  LAND REJECT  ----------------- //

            function LandReject(uint _LandId) public {
          VerifyLand[_LandId] = false;
            }



             // ----------------  END  ----------------- //




             // ----------------  SELLER UPDATE  ----------------- //
            
            function SellerUpdate(address _addr,string memory _Name,
            uint _Age,string memory _City,uint _Cnic,string memory _Email) public {
                seller[_addr].Name=_Name;
                seller[_addr].Age= _Age;
                seller[_addr].City=_City;
                seller[_addr].Cnic=_Cnic;
                seller[_addr].Email=_Email;
           }
          

             // ----------------  END  ----------------- //





             // ----------------  CHECK OWNER BY LAND ID ----------------- //


           function getLandOwnerById(uint _id) public view returns(address) {

               return land[_id].Owner;
          }

             // ----------------  END  ----------------- //




             // ----------------  PART TWO BUYER  ----------------- //
       



             // ----------------  BUYER REGISTER FUNCTION  ----------------- //

          function BuyerRegister(address _key ,string memory _Name,uint _Age,
           string memory _City,uint _Cnic,string memory  _Email) public {
          buyer[_key] = BuyerDetails(_Name,_Age,_City,_Cnic,_Email);
          VerifiedBuyer[msg.sender] = false;
          }


             // ----------------  END  ----------------- //






             // ----------------  BUYER VERIFY FUNCTION  ----------------- //

       function BuyerVerified(address _addr) public {
       VerifiedBuyer[_addr] = true;
           }

             // ----------------  END  ----------------- //






             // ----------------  BUYER REJECT FUNCTION  ----------------- //

        function BuyerReject(address _addr) public {
          VerifiedBuyer[_addr] = false;
           }

             // ----------------  END  ----------------- //



    

             // ----------------  BUYER UPDATE FUNCTION  ----------------- //

       function UpdateBuyer(address _addr,
       string memory _Name,
       uint _Age,
       string memory _City,
       uint _Cnic,
       string memory _Email) public 
       {
                 buyer[_addr].Name=_Name;
                 buyer[_addr].Age= _Age;
                 buyer[_addr].City=_City;
                 buyer[_addr].Cnic=_Cnic;
                 buyer[_addr].Email=_Email;
           }   

             // ----------------  END  ----------------- //





             // ---------------- GET OWNER BU ID FUNCTION ----------------- //

     function GetCurrentOwner(uint _LandId) public view returns (address _addr){
       return land[_LandId].Owner;
     }

             // ----------------  END  ----------------- //

         


             // -------//--------- LAST INDIVIDUAL CALL FUNCTION --------//--------- //






      
             // ----------------  GET LAND CITY FUNCTION  ----------------- //

        function GetLandCity(uint _LandId) public view returns(string memory _City){
            return land[_LandId].City;   
        }

             // ----------------  END  ----------------- //




             // ----------------  GET LAND PRICE FUNCTION  ----------------- //

        function GetLandPrice(uint _LandId) public view returns(uint _LandPrice){
            return land[_LandId].LandPrice;
        }

             // ----------------  END  ----------------- //




             // ----------------  GET LAND AREA FUNCTION  ----------------- //

        function GetLandArea(uint _LandId) public view returns(string memory _Area){
            return land[_LandId].Area;
        }
             // ----------------  END  ----------------- //





             // ----------------  BUY LAND FUNCTION  ----------------- //
 
      function BuyLand(uint _LandId) public payable{
        require(VerifiedBuyer[msg.sender] == true,"error in buyer");
        require(VerifyLand[_LandId] == true,"error in seller");
        payable(land[_LandId].Owner).transfer(msg.value);
        land[_LandId].Owner=msg.sender;
           }
          
          // ----------------  END  ----------------- //

}
