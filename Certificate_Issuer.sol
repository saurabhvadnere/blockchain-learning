// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract CertificateIssuer {

    address public issuer;

    struct Certificate {
        string studentName;
        string course;
        uint issuedOn;
        bool valid;
    }

    mapping(uint => Certificate) public certificates;
    uint public certificateCount;

    event CertificateIssued(uint certificateId,string studentName,string course);
    
    constructor() {
        issuer = msg.sender;
    }

    modifier onlyIssuer() {
        require(msg.sender == issuer, "Only issuer can perform this action");
        _;
    }

    function issueCertificate(string memory _studentName,string memory _course) public onlyIssuer {

        certificateCount++;

        certificates[certificateCount] = Certificate({studentName: _studentName,course: _course,issuedOn: block
        .timestamp,valid: true});
            
        emit CertificateIssued(certificateCount,_studentName,_course);
    }

    function verifyCertificate(uint _id)public view returns (string memory studentName,string memory course
    ,uint issuedOn,bool valid )
    
    {
        Certificate memory cert = certificates[_id];
        return (
            cert.studentName,
            cert.course,
            cert.issuedOn,
            cert.valid
        );
    }
}
