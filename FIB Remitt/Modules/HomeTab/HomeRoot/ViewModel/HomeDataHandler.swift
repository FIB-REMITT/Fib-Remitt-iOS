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
    var deliveryMethodType = "Bank Transfer"
    func clear(){
        purposes.removeAll()
        deliveryMethodType = ""
    }
}
