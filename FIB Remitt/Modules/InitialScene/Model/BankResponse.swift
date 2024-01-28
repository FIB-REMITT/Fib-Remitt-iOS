//
//  BankResponse.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 28/1/24.
//

import Foundation

struct BankResponse: Codable, CustomStringConvertible {
    var description: String{ return "" }
    
    var id:String?
    var name: String?
    var status: Bool?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case status

    }
}
/*
 [
     {
         "id": "093b2830-2b22-41cd-acd4-304653a81d3f",
         "name": "AB Bank Limited",
         "status": true
     }]
 */
