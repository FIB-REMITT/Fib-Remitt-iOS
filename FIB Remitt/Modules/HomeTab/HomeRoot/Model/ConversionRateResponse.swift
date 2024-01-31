//
//  ConversionRateResponse.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 31/1/24.
//

import Foundation

// MARK: - Transaction
struct ConversionRateResponse: Codable {
    let AED: Double?
    let BDT: Double?
    let USD: Double?
    let TRY: Double?
    let IQD: Double?

    enum CodingKeys: String, CodingKey {
        case AED
        case BDT
        case USD
        case TRY
        case IQD

    }
    
    func toDictionary() -> [String: Double] {
            var dictionary: [String: Double] = [:]

            let mirror = Mirror(reflecting: self)

            for (key, value) in mirror.children {
                if let key = key as? String, let value = value as? Double {
                    dictionary[key] = value
                }
            }

            return dictionary
        }
}

/*
 {
     "AED": 0.002801,
     "BDT": 0.083779,
     "USD": 0.000763,
     "TRY": 0.023157,
     "IQD": 1.0
 }
 */
