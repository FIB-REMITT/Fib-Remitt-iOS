//
//  CurrencyResponse.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 28/1/24.
//

import Foundation

struct CurrencyResponse: Codable, CustomStringConvertible {
    var description: String{ return "" }
    
    var id:String?
    var name: String?
    var symbol:String?
    var code: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case symbol
        case code

    }
}
/*
 [
     {
         "id": "c7448546-0978-4f22-80d0-05e6807a0851",
         "symbol": "Tk",
         "name": "Bangladeshi Taka",
         "code": "BDT"
     }]
 */
