//
//  PurposeResponse.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 28/1/24.
//

import Foundation

struct PurposeResponse: Codable, CustomStringConvertible {
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
         "id": "7bd96326-c76d-4920-adff-9f03b2fd0df3",
         "code": "Account Opening",
         "name": "Account Opening",
         "gateway": "PARAGRAM",
         "status": true,
         "createdAt": "2024-01-25T10:55:56.545+00:00",
         "updatedAt": "2024-01-25T10:55:56.545+00:00"
     }]
 */
