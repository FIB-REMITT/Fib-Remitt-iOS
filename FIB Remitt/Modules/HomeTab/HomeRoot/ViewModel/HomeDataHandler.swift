//
//  HomeDataHandler.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 29/1/24.
//

import Foundation

class HomeDataHandler{
    
    static let shared = HomeDataHandler()
    private init(){}

    var purposes: [PurposeResponse] = []
    var deliveryMethodType : String = "Bank Transfer"
    var fromCurrency       : String = "IQD"
    var toCurrency         : String = ""
    var paymentMethod      : String = ""
    var collectionPoint    : String = ""
    var purposeId          : String = ""
    
    func clear(){
        purposes.removeAll()
        deliveryMethodType  = ""
        fromCurrency        = ""
        toCurrency          = ""
        paymentMethod       = ""
        collectionPoint     = ""
        purposeId           = ""
    }
}
