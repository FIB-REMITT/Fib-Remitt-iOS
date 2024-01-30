//
//  StringData.swift
//  FIB Remitt
//
//  Created by Raihan on 30/1/24.
//

import Foundation

extension Optional where Wrapped == String {
    var isBlankOrEmptyOrNil: Bool {
        return self?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true
    }
}

extension String {
    var isBlankOrEmpty: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
