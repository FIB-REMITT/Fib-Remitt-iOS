//
//  CurrencyResponse.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 28/1/24.
//

import Foundation

struct CurrencyResponse: Codable, CustomStringConvertible, Identifiable {
    var description: String{ return "" }
    
    var id:String?     =  "cdfde334-099b-41be-9333-8c1e6147675e"
    var name: String?  =  "Turkish Lira"
    var symbol:String?
    var code: String?  = "TRY"

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
