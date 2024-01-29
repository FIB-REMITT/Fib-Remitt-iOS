//
//  ConfirmationByTransactionResponse.swift
//  FIB Remitt
//
//  Created by Raihan on 28/1/24.
//

import Foundation


// MARK: - ConfirmationByTransactionResponse
struct ConfirmationByTransactionResponse: Codable {
    let paymentId: String?
    let readableCode: String?
    let qrCode: String?
    let validUntil: String?
    let personalAppLink: String?
    let businessAppLink: String?
    let corporateAppLink: String?

    enum CodingKeys: String, CodingKey {
        case paymentId = "paymentId"
        case readableCode = "readableCode"
        case qrCode = "qrCode"
        case validUntil = "validUntil"
        case personalAppLink = "personalAppLink"
        case businessAppLink = "businessAppLink"
        case corporateAppLink = "corporateAppLink"
    }
}
