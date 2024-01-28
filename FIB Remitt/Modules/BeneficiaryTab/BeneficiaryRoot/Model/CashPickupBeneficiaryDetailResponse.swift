//
//  CashPickupBeneficiaryDetail.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 28/1/24.
//

import Foundation

struct CashPickupBeneficiaryDetailResponse: Codable, CustomStringConvertible {
    var description: String{ return "" }
    
    var id:String?
    var fullName:String?
    var phoneNumber: String?
    var nationality:String?
    var status: Bool?
    var address: String?
    var gender: String?
    var typeOfBeneficiary: String?
    var relationship: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case fullName
        case phoneNumber
        case nationality
        case status
        case address
        case gender
        case typeOfBeneficiary
        case relationship
    }
}

/*
 {
     "id": "69b32b4c-c66b-4daa-9814-26e8efa5a499",
     "fullName": "Tamim Mridha",
     "phoneNumber": "+880156141179",
     "nationality": "Afganistan",
     "address": "Mirpur DOHS, Dhaka, Bangladesh",
     "gender": "Male",
     "typeOfBeneficiary": "Personal",
     "relationship": "Friend",
     "status": true
 }
 */
