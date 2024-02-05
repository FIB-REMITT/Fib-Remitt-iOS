//
//  TransactionDataHandler.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 5/2/24.
//

import Foundation

class TransactionDataHandler{
    
    static let shared = TransactionDataHandler()
    private init(){}

    var currentTransactionPageNo           : Int = 0

    
    func clear(){
        currentTransactionPageNo = 0
    }
}
