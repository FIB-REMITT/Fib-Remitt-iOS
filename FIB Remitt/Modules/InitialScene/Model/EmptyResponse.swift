//
//  EmptyResponse.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 25/1/24.
//

import Foundation

struct EmptyResponse: Decodable {
    init(from decoder: Decoder) throws {
        // No properties to decode, so nothing to do here
    }
}
