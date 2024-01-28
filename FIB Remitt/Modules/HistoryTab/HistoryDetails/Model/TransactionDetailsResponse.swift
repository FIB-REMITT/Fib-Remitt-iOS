//
//  TransactionDetailsResponse.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 28/1/24.
//


import Foundation

// MARK: - TransactionDetails
struct TransactionDetailsResponse: Codable, CustomStringConvertible {
    var description: String{ return "" }
    let message: String?
    let errors: [String]?
    let data: TransactionDetailContent?
    
    enum CodingKeys: String, CodingKey {
        case message = "message"
        case errors = "errors"
        case data = "data"
    }
    
    init(message: String?, errors: [String]?, data: TransactionDetailContent?){
        self.message = message
        self.errors = errors
        self.data = data
    }
}

// MARK: - DataClass
struct TransactionDetailContent: Codable, CustomStringConvertible {
    var description: String{ return "" }
    
    let transactionNumber: String?
    let collectionPoint: String?
    let transaction: Transaction?
    let receiver: ReceiverData?
    let sender: String?
    let status: String?
    let createdAt: String?
    let updatedAt: String?
    
    enum CodingKeys: String, CodingKey {
        case transactionNumber = "transactionNumber"
        case collectionPoint = "collectionPoint"
        case transaction = "transaction"
        case receiver = "receiver"
        case sender = "sender"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }
    
    init(transactionNumber: String?, collectionPoint: String?, transaction: Transaction?, receiver: ReceiverData?, sender: String?,status: String?, createdAt: String?, updatedAt: String?) {
        self.transactionNumber = transactionNumber
        self.collectionPoint = collectionPoint
        self.transaction = transaction
        self.receiver = receiver
        self.sender = sender
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: - Receiver
struct ReceiverData: Codable, CustomStringConvertible {
    var description: String{ return "" }
    let bankDetails: BankDetails?
    
    enum CodingKeys: String, CodingKey {
        case bankDetails = "bankDetails"
    }
    
    init(bankDetails: BankDetails?){
        self.bankDetails = bankDetails
    }
}

// MARK: - BankDetails
struct BankDetails: Codable, CustomStringConvertible {
    var description: String{ return "" }
    let fullName: String?
    let accountNumber: String?
    let bankName: String?
    let phoneNumber: String?
    let typeOfBeneficiary: String?
    let address: String?
    let relationship: String?
    
    enum CodingKeys: String, CodingKey {
        case fullName = "fullName"
        case accountNumber = "accountNumber"
        case bankName = "bankName"
        case phoneNumber = "phoneNumber"
        case typeOfBeneficiary = "typeOfBeneficiary"
        case address = "address"
        case relationship = "relationship"
    }
    
    init(fullName: String?, accountNumber: String?,bankName: String?,phoneNumber: String?, typeOfBeneficiary: String?,address: String?,relationship: String?){
        self.fullName = fullName
        self.accountNumber = accountNumber
        self.bankName = bankName
        self.phoneNumber = phoneNumber
        self.typeOfBeneficiary = typeOfBeneficiary
        self.address = address
        self.relationship = relationship
    }
}

// MARK: - Transaction
struct TransactionList: Codable, CustomStringConvertible {
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
    
    init(fromCurrency: String?,amountToTransfer: Int?,toCurrency: String?,totalPayable: Int?,charge: Int?,amountReceivable: Double?){
        self.fromCurrency = fromCurrency
        self.amountToTransfer = amountToTransfer
        self.toCurrency = toCurrency
        self.totalPayable = totalPayable
        self.charge = charge
        self.amountReceivable = amountReceivable
    }
}
