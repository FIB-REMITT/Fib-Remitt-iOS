//
//  BankCollectionResponse.swift
//  FIB Remitt
//
//  Created by Raihan on 28/1/24.
//

import Foundation


// MARK: - BankCollectionResponse
struct BankCollectionResponse: Codable {
    let transactionNumber: String?
    let countryName: String?
    let purposeTitle: String?
    let collectionPoint: String?
    let transaction: BankCollectionTransaction?
    let receiver: bankCollectionReceiver?

    enum CodingKeys: String, CodingKey {
        case transactionNumber = "transactionNumber"
        case countryName = "countryName"
        case purposeTitle = "purposeTitle"
        case collectionPoint = "collectionPoint"
        case transaction = "transaction"
        case receiver = "receiver"
    }
}

// MARK: - Receiver
struct bankCollectionReceiver: Codable {
    let fullName: String?
    let phoneNumber: String?
    let nationality: String?
    let address: String?
    let gender: String?
    let typeOfBeneficiary: String?
    let relationship: String?
    let accountNumber: String?
    let bankName: String?

    enum CodingKeys: String, CodingKey {
        case fullName = "fullName"
        case phoneNumber = "phoneNumber"
        case nationality = "nationality"
        case address = "address"
        case gender = "gender"
        case typeOfBeneficiary = "typeOfBeneficiary"
        case relationship = "relationship"
        case accountNumber = "accountNumber"
        case bankName = "bankName"
    }
}

// MARK: - Transaction
struct BankCollectionTransaction: Codable {
    let fromCurrency: String?
    let amountToTransfer: Int?
    let toCurrency: String?
    let totalPayable: Int?
    let charge: Int?
    let amountReceivable: Double?

    enum CodingKeys: String, CodingKey {
        case fromCurrency = "fromCurrency"
        case amountToTransfer = "amountToTransfer"
        case toCurrency = "toCurrency"
        case totalPayable = "totalPayable"
        case charge = "charge"
        case amountReceivable = "amountReceivable"
    }
}
