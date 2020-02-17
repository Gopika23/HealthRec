pragma solidity ^0.5.10;
contract Patient {
    mapping (address => patient) internal patients;
    mapping (address => mapping (address => uint)) internal patientToDoctor;
    mapping (address => mapping (bytes32 => uint)) internal patientToFile;
    
    struct patient {
        string name;
        uint8 age;
        address id;
        bytes32[] files;
        address[] doctor_list;
    }
    
    modifier checkPatient(address id) {
        patient p = patients[id];
        require(p.id > 0x0);
        _;
    }
    
    function patientInfo() public view checkPatient(msg.sender) returns(string, uint8, bytes32[], address[]) {
        patient p = patients[msg.sender];
        return (p.name, p.age, p.files, p.doctor_list);
    }
    
    function newPatient(string _name, uint8 _age) public {
        patient p = patients[msg.sender];
        
        require((_age > 0) && (_age < 100));
        require(!(p.id > 0x0));

        patients[msg.sender] = patient({name:_name,age:_age,id:msg.sender,files:new bytes32[](0),doctor_list:new address[](0)});
    }

}