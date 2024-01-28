//
//  TransactionDetailsResponse.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 28/1/24.
//



import Foundation

// MARK: - TransactionDetailsResponse
struct TransactionDetailsResponse: Codable {
    let transactionNumber: String?
    let receiver: DetailsReceiver?
    let collectionPoint: String?
    let purposeTitle: String?
    let transaction: DetailsTransaction?
    let status: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case transactionNumber = "transactionNumber"
        case receiver = "receiver"
        case collectionPoint = "collectionPoint"
        case purposeTitle = "purposeTitle"
        case transaction = "transaction"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
}

// MARK: - Receiver
struct DetailsReceiver: Codable {
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
struct DetailsTransaction: Codable {
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
