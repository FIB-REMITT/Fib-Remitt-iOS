//
//  BankBeneficiariesResponse.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 28/1/24.
//

import Foundation

struct BankBeneficiariesResponse: Codable, CustomStringConvertible {
    var description: String{ return "" }
    
    var bankBeneficiaryBankDTO:BankBeneficiariesDTO?
    var id:String?
    var fullName:String?
    var phoneNumber: String?
    var accountNumber: String?
    var nationality:String?
    var address: String?
    var gender: String?
    var typeOfBeneficiary: String?
    var relationship: String?
    var status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case bankBeneficiaryBankDTO
        case id
        case fullName
        case phoneNumber
        case nationality
        case address
        case gender
        case typeOfBeneficiary
        case relationship
        case status
    }
}

struct BankBeneficiariesDTO : Codable, CustomStringConvertible {
    var description: String{ return "" }
    
    var id:String?
    var fullName:String?
    var status: Bool?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName
        case status
    }
}
/*
 [{
        "bankBeneficiaryBankDTO": {
            "id": "0fd3997d-3c3a-46bb-aa3e-f0ccf45725d3",
            "name": "Mercantile Bank Limited",
            "status": true
        },
        "id": "57d1c26a-37d1-4f16-ac42-bb90aea13573",
        "fullName": "Fahim Foysal Emonfdsf",
        "accountNumber": "09995874574",
        "phoneNumber": "+88019614117324324",
        "nationality": "Amerika Birleşik Devletleri",
        "address": "Mirpur DOHS, Dhaka, Bangladesh",
        "gender": "Male",
        "typeOfBeneficiary": "Personal",
        "relationship": "Friend",
        "status": true
    }]
 */
