//
//  BeneficiaryEnum.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 29/1/24.
//

import Foundation


enum CollectionPoint:String, CaseIterable{

    case all
    case bank_Transfer
    case cash_Pickup
    
    
    var title: String{
        switch self {
        case .bank_Transfer : return "Bank Transfer"
        case .cash_Pickup   : return "Cash Pickup"
        case .all           : return "All"
        }
    }
    
    var icon: String{
        switch self {
        case .bank_Transfer : return "bank_ico"
        case .cash_Pickup   : return ""
        case .all           : return ""
        }
    }
}
