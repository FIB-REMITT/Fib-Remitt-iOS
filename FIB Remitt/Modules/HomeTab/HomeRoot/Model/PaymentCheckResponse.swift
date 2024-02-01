//
//  PaymentCheckResponse.swift
//  FIB Remitt
//
//  Created by Raihan on 1/2/24.
//

import Foundation


struct PaymentCheckResponse : Codable {
    
    let status: Bool?

    enum CodingKeys: String, CodingKey {
        case status = "status"
    }
}
extension PaymentCheckResponse: Equatable {
    static func == (lhs: PaymentCheckResponse, rhs: PaymentCheckResponse) -> Bool {
        // Define how to compare two PaymentCheckResponse objects for equality here
        return lhs.status == rhs.status // Adjust the comparison as needed
    }
}
