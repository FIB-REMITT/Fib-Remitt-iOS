//
//  TransactionDetailsResponse.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 28/1/24.
//


import Foundation

// MARK: - TransactionDetailsResponse
struct TransactionDetailsResponse: Codable ,CustomStringConvertible {
    var description: String{ return "" }
    
    let transactionNumber: String?
    let receiver: String?
    let collectionPoint: String?
    let purposeTitle: String?
    let transaction: TransactionData?
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

// MARK: - Transaction Details Data
struct TransactionData: Codable ,CustomStringConvertible {
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
