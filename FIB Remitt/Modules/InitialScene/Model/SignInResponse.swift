//
//  SignInResponse.swift
//  FIB Remitt
//
//  Created by Izak on 28/1/24.
//

import Foundation

struct SignInResponse: Codable, CustomStringConvertible {
    var description: String{
        return ""
    }
    var message:String?
    var errors:[String]?
    var data: SignInData?
    
    enum CodingKeys: String, CodingKey {
        case message
        case errors
        case data
    }
}

struct SignInData: Codable, CustomStringConvertible {
    var description: String{ return "" }
    var access_token:String?
    var refresh_token:String?
    var token_type: String?
    var id_token: String?
    var session_state:String?
    var scope: String?
    var expires_in: Int?
    var refresh_expires_in: Int?
    var notBeforePolicy: Int?
    
    enum CodingKeys: String, CodingKey {
        case access_token
        case refresh_token
        case token_type
        case id_token
        case session_state
        case scope
        case expires_in
        case refresh_expires_in
        case notBeforePolicy = "not-before-policy"
        
    }
}

/*
 {
     "message": "Request Successful.",
     "errors": [],
     "data": {
         "access_token": "eyJhbGciOiJSUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJXNFVMSHE0RERocm0xbmZxYVFnWlcxLVhDTlBXTGx5YUxpSn",
         "expires_in": 86400,
         "refresh_expires_in": 2592000,
         "refresh_token": "eyJhbGciOiJIUzI1NiIsInR5cCIgOiAiSldUIiwia2lkIiA6ICJjMDQyODNlOC1jOWRhLTQ4NzgtODBkMC0wOTM1NGNiMGQxMD",
         "token_type": "Bearer",
         "id_token": null,
         "not-before-policy": 0,
         "session_state": "5223407a-4807-490a-8914-e22f9725153e",
         "scope": "email profile"
     }
 }
 */
