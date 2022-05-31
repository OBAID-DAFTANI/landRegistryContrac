//SPDX-License-Identifier: GPL-3.0;

pragma solidity ^0.8.7;

contract LandRegistry{

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
   

         ////////////////////STRUCT ENDS////////////////////////////////// 

  

 
/////////////////////////////Add land inspector/////////////////////////////////////////////

   function Landinspector(address _addr,string memory _name,uint _age,
   string memory _designation) public {
       landInspector[msg.sender] = LandInspector(_addr,_name,_age,_designation);
   }
   

             //////////////////MAPPING START//////////////////////////////////////
  
    mapping(uint => landregistry) public land;
    mapping(address=> BuyerDetails) public buyer;
    mapping(address => SellerDetails) public seller;
    mapping(address => LandInspector) public landInspector;
    mapping (address => bool) public VerifiedSeller;
    mapping(address => bool) public VerifiedBuyer;
    mapping (uint => bool) public VerifyLand;
    // mapping (uint => address) public GetLandOwner;

   //....................................END...............................//

     
    //////Createe Function to Register Seller//////////

    function registerSeller(uint _id,
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
   //....................................END...............................//
  
    /////FUNCTION TO VERIFY SELLER///////////
      function SellerVerified(address _addr) public {
       VerifiedSeller[_addr] = true;
           }
 
   //....................................END...............................//


/////////function to reject seller///////////

           function SellerReject(address _addr) public  {
          VerifiedSeller[_addr] = false;
           }



   //....................................END...............................//



      //////////////////land Register function////////////


      function registerLand(uint _LandId, address, string memory _Area, string memory _City, string memory _State, uint _LandPrice, uint _PropertyId) public {
             land[_LandId] =landregistry(msg.sender, _Area, _City, _State, _LandPrice, _PropertyId);
             VerifyLand[_LandId] = false;
             
           }


   //....................................END...............................//



//////////////////////////////////////verify land//////////////////////////


            function VerifyingLand(uint _LandId) public {
          VerifyLand[_LandId] = true;
           }


   //....................................END...............................//




           ////////////////Reject land//////////////

            function RejectLand(uint _LandId) public {
          VerifyLand[_LandId] = false;
            }



   //....................................END...............................//



            ////////////////////////////update seller//////////////////////////
            
            function updateSeller(address _addr,string memory _Name,
            uint _Age,string memory _City,uint _Cnic,string memory _Email) public {
                seller[_addr].Name=_Name;
                seller[_addr].Age= _Age;
                seller[_addr].City=_City;
                seller[_addr].Cnic=_Cnic;
                seller[_addr].Email=_Email;
           }
          

   //....................................END...............................//


           ///////////cHECK OWNER BY LAND ID//////////////

///FIRST FOR INDIVIDUAL.
           function getLandOwnerById(uint _id) public view returns(address) {

               return land[_id].Owner;
          }


   //....................................END...............................//


          /////////////// PART 2 OF BUYER/////////////////////
       


          //////////////Register BUyer Function///////////////////////

          function RegisterBuyer(address _key ,string memory _Name,uint _Age,string memory _City,uint _Cnic,string memory  _Email) public {
          buyer[_key] = BuyerDetails(_Name,_Age,_City,_Cnic,_Email);
          VerifiedBuyer[msg.sender] = false;
          }


   //....................................END...............................//


          /////////////VERIFY BUYER FUNCTION///////////////////////////
       function BuyerVerified(address _addr) public {
       VerifiedBuyer[_addr] = true;
           }

   //....................................END...............................//

       //////Reject buyer Function///////////////////////

        function BuyerReject(address _addr) public {
          VerifiedBuyer[_addr] = false;
           }

   //....................................END...............................//


    

    ///////////////////////////////// UPDATE BUYER ///////////////////////////////  

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

   //....................................END...............................//


////////////////////////// Getting owner by id//////////////////////////////

     function GetCurrentOwner(uint _LandId) public view returns (address _addr){
       return land[_LandId].Owner;
     }


   //....................................END...............................//

         



         /////////////////////////////LAST INDIVIDUAL CALL FUNCTION//////////////////////////
        

        //////FUNCTION TO GET LAND CITY/////////////////////

        function GetLandCity(uint _LandId) public view returns(string memory _City){
            return land[_LandId].City;
        }

   //....................................END...............................//


        ///////////////////////FUNCTION GET LAND PRICE////////////////////////////
        function GetLandPrice(uint _LandId) public view returns(uint _LandPrice){
            return land[_LandId].LandPrice;
        }

   //....................................END...............................//



        /////// FUNCTION TO GET LAND AREA///////////////////////
        function GetLandArea(uint _LandId) public view returns(string memory _Area){
            return land[_LandId].Area;
        }
   //....................................END...............................//



 /////////////////////////////////// BUY LAND///////////////////////////////////////////


 
      function BuyLand(uint _LandId) public payable{
        require(VerifiedBuyer[msg.sender] == true,"error in buyer");
        require(VerifyLand[_LandId] == true,"error in seller");
        payable(land[_LandId].Owner).transfer(msg.value);
        land[_LandId].Owner=msg.sender;


          }
}
