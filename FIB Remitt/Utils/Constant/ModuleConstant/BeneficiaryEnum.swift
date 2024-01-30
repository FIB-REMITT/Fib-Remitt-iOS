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

enum AvailableBeneficiaryType : String, CaseIterable{
    case bank_Transfer
    case cash_Pickup

    var title: String{
        switch self {
        case .bank_Transfer : return "Bank Beneficiary"
        case .cash_Pickup   : return "Cash Pickup Beneficiary"
        }
    }
    
    var icon: String{
        switch self {
        case .bank_Transfer : return "bank_ico"
        case .cash_Pickup   : return ""
        }
    }
}

enum Gender:String, CaseIterable{
    case male
    case female

    var title: String{
        switch self {
        case .male : return "Male"
        case .female   : return "Female"
        }
    }
}

enum BeneficiaryAccountType:String, CaseIterable{
    case personal
    case buissness

    var title: String{
        switch self {
        case .personal : return "Personal"
        case .buissness   : return "Buisness"
        }
    }
}
