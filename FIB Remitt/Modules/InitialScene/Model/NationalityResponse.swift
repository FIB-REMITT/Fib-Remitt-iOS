//
//  NationalityResponse.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 28/1/24.
//

import Foundation

struct NationalityResponse: Codable, CustomStringConvertible {
    var description: String{ return "" }
    
    var id:String?
    var code:String?
    var name: String?
    var gateway:String?
    var status: Bool?
    var createdAt: String?
    var updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case code
        case name
        case gateway
        case status
        case createdAt
        case updatedAt
    }
}
/*
 [{
         "id": "87d62a40-2dff-4e98-94b5-a1402cf95179",
         "code": "AF",
         "name": "Afganistan",
         "gateway": "PARAGRAM",
         "status": false,
         "createdAt": "2024-01-25T10:55:55.766+00:00",
         "updatedAt": "2024-01-25T10:55:55.766+00:00"
     }]
 */
