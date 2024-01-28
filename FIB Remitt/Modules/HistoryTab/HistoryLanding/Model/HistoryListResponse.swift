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
    
    let content: [TransactionListContent]?
    let pageable: TransactionListPageable?
    let totalPages: Int?
    let totalElements: Int?
    let last: Bool?
    let size: Int?
    let number: Int?
    let sort: TransactionListSort?
    let numberOfElements: Int?
    let first: Bool?
    let empty: Bool?

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

    init(content: [TransactionListContent]?, pageable: TransactionListPageable?, totalPages: Int?, totalElements: Int?, last: Bool?, size: Int?, number: Int?, sort: TransactionListSort?, numberOfElements: Int?, first: Bool?, empty: Bool?) {
        self.content = content
        self.pageable = pageable
        self.totalPages = totalPages
        self.totalElements = totalElements
        self.last = last
        self.size = size
        self.number = number
        self.sort = sort
        self.numberOfElements = numberOfElements
        self.first = first
        self.empty = empty
    }
}

// MARK: - Content
struct TransactionListContent: Codable,CustomStringConvertible {
    var description: String{ return "" }
    
    let transactionNumber: String?
    let originCountry: String?
    let destinationCountry: String?
    let recipientName: String?
    let collectionPoint: String?
    let purposeTitle: String?
    let transaction: Transaction?
    let status: String?
    let createdAt: String?
    let updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case transactionNumber = "transactionNumber"
        case originCountry = "originCountry"
        case destinationCountry = "destinationCountry"
        case recipientName = "recipientName"
        case collectionPoint = "collectionPoint"
        case purposeTitle = "purposeTitle"
        case transaction = "transaction"
        case status = "status"
        case createdAt = "createdAt"
        case updatedAt = "updatedAt"
    }

    init(transactionNumber: String?, originCountry: String?, destinationCountry: String?, recipientName: String?, collectionPoint: String?, purposeTitle: String?, transaction: Transaction?, status: String?, createdAt: String?, updatedAt: String?) {
        self.transactionNumber = transactionNumber
        self.originCountry = originCountry
        self.destinationCountry = destinationCountry
        self.recipientName = recipientName
        self.collectionPoint = collectionPoint
        self.purposeTitle = purposeTitle
        self.transaction = transaction
        self.status = status
        self.createdAt = createdAt
        self.updatedAt = updatedAt
    }
}

// MARK: - Transaction
struct Transaction: Codable,CustomStringConvertible{
    
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

    init(fromCurrency: String?, amountToTransfer: Int?, toCurrency: String?, totalPayable: Int?, charge: Int?, amountReceivable: Double?) {
        self.fromCurrency = fromCurrency
        self.amountToTransfer = amountToTransfer
        self.toCurrency = toCurrency
        self.totalPayable = totalPayable
        self.charge = charge
        self.amountReceivable = amountReceivable
    }
}

// MARK: - TransactionListPageable
struct TransactionListPageable: Codable,CustomStringConvertible {
    var description: String{ return "" }
    
    let sort: TransactionListSort?
    let pageNumber: Int?
    let pageSize: Int?
    let offset: Int?
    let paged: Bool?
    let unpaged: Bool?

    enum CodingKeys: String, CodingKey {
        case sort = "sort"
        case pageNumber = "pageNumber"
        case pageSize = "pageSize"
        case offset = "offset"
        case paged = "paged"
        case unpaged = "unpaged"
    }

    init(sort: TransactionListSort?, pageNumber: Int?, pageSize: Int?, offset: Int?, paged: Bool?, unpaged: Bool?) {
        self.sort = sort
        self.pageNumber = pageNumber
        self.pageSize = pageSize
        self.offset = offset
        self.paged = paged
        self.unpaged = unpaged
    }
}

// MARK: - Sort
struct TransactionListSort: Codable,CustomStringConvertible {
    var description: String{ return "" }
    let sorted: Bool?
    let empty: Bool?
    let unsorted: Bool?

    enum CodingKeys: String, CodingKey {
        case sorted = "sorted"
        case empty = "empty"
        case unsorted = "unsorted"
    }

    init(sorted: Bool?, empty: Bool?, unsorted: Bool?) {
        self.sorted = sorted
        self.empty = empty
        self.unsorted = unsorted
    }
}
