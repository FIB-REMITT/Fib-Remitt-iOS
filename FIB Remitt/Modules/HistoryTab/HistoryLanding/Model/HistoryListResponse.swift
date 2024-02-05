//
//  HistoryListResponse.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 28/1/24.
//

import Foundation

// MARK: - TransactionHistoryResponse
struct TransactionHistoryResponse: Codable,CustomStringConvertible {
    var description: String{ return "" }
    var content: [TransactionListContent]?
    var pageable: TransactionPageable?
    var totalPages: Int?
    var totalElements: Int?
    var last: Bool?
    var size: Int?
    var number: Int?
    var sort: TransactionSort?
    var numberOfElements: Int?
    var first: Bool?
    var empty: Bool?

    enum CodingKeys: String, CodingKey {
        case content = "content"
        case pageable = "pageable"
        case totalPages = "totalPages"
        case totalElements = "totalElements"
        case last = "last"
        case size = "size"
        case number = "number"
        case sort = "sort"
        case numberOfElements = "numberOfElements"
        case first = "first"
        case empty = "empty"
    }
}

// MARK: - Content
struct TransactionListContent: Codable,Identifiable,CustomStringConvertible {
    var description: String{ return "" }
    var id = UUID()
    let transactionNumber: String?
    let receiver: Receiver?
    let collectionPoint: String?
    let purposeTitle: String?
    let transaction: Transaction?
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
struct Receiver: Codable {
    var fullName: String?
    var phoneNumber: String?
    var nationality: String?
    var address: String?
    var gender: String?
    var typeOfBeneficiary: String?
    var relationship: String?
    var accountNumber: String?
    var bankName: String?

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
struct Transaction: Codable , CustomStringConvertible{
    var description: String{ return "" }
    var fromCurrency: String?
    var amountToTransfer: Double?
    var toCurrency: String?
    var totalPayable: Double?
    var charge: Double?
    var amountReceivable: Double?

    enum CodingKeys: String, CodingKey {
        case fromCurrency = "fromCurrency"
        case amountToTransfer = "amountToTransfer"
        case toCurrency = "toCurrency"
        case totalPayable = "totalPayable"
        case charge = "charge"
        case amountReceivable = "amountReceivable"
    }
}

// MARK: - Pageable
struct TransactionPageable: Codable,CustomStringConvertible {
    var description: String{ return "" }
    var sort: TransactionSort?
    var pageNumber: Int?
    var pageSize: Int?
    var offset: Int?
    var unpaged: Bool?
    var paged: Bool?
    
    enum CodingKeys: String, CodingKey {
        case sort = "sort"
        case pageNumber = "pageNumber"
        case pageSize = "pageSize"
        case offset = "offset"
        case unpaged = "unpaged"
        case paged = "paged"
    }
}

// MARK: - Sort
struct TransactionSort: Codable,CustomStringConvertible {
    var description: String{ return "" }
    var sorted: Bool?
        var empty: Bool?
        var unsorted: Bool?

        enum CodingKeys: String, CodingKey {
            case sorted = "sorted"
            case empty = "empty"
            case unsorted = "unsorted"
        }
}
