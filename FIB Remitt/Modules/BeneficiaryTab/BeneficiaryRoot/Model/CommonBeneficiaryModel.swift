//
//  CommonBeneficiaryModel.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 30/1/24.
//

import Foundation

struct CommonBeneficiaryModel:Hashable {
    static func == (lhs: CommonBeneficiaryModel, rhs: CommonBeneficiaryModel) -> Bool { lhs.id == rhs.id }
    func hash(into hasher: inout Hasher) { }
    var description: String{ return "" }
    
    var id:String?
    var title:String?
    var subTitle: String?
    var address:String?
    var beneficiaryType : CollectionPoint
    var accTypeIsBuiessness: Bool?
    
}
