//
//  TransactionDetailsResponse.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 28/1/24.
//



import Foundation


// MARK: - TransactionDetailsResponse
struct TransactionDetailsResponse: Codable,CustomStringConvertible {
    var description: String{ return "" }
    let transactionNumber: String?
    let receiver: DetailsReceiver?
    let collectionPoint: String?
    let purposeTitle: String?
    let transaction: DetailsTransaction?
    let status: String?
    let createdAt: String?
    let updatedAt: String?
    let progress: [DetailsProgress]?

    enum CodingKeys: String, CodingKey {
        case transactionNumber = "transactionNumber"
        case receiver = "receiver"
        case collectionPoint = "collectionPoint"
        case purposeTitle = "purposeTitle"
        case transaction = "transaction"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
        case progress = "progress"
    }
}

// MARK: - Progress
struct DetailsProgress: Codable,CustomStringConvertible {
    var description: String{ return "" }
    let id: String?
    let transactionId: String?
    let transactionUid: String?
    let state: String?
    let message: String?
    let createdAt: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case transactionId = "transactionId"
        case transactionUid = "transactionUid"
        case state = "state"
        case message = "message"
        case createdAt = "createdAt"
    }
}

// MARK: - Receiver
struct DetailsReceiver: Codable,CustomStringConvertible {
    var description: String{ return "" }
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
struct DetailsTransaction: Codable,CustomStringConvertible {
    var description: String{ return "" }
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
