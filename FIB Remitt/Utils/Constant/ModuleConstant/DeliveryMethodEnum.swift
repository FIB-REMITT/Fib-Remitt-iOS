//
//  DeliveryMethodEnum.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 25/1/24.
//

import Foundation

enum DeliveryMethodEnum: Int, CaseIterable{
    
    case bank_Transfer,
         cash_Pickup
    
    var id: Int {
        switch self {
        case .bank_Transfer: return 1
        case .cash_Pickup: return 2
        }
    }
    
    var title: String{
        switch self {
        case .bank_Transfer: return "Bank Transfer"
        case .cash_Pickup: return "Cash Pickup"
            
        }
    }
}
