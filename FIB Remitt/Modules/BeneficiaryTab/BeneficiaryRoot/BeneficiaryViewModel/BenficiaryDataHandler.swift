//
//  BenficiaryDataHandler.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 30/1/24.
//

import Foundation

class BenficiaryDataHandler{
    
    static let shared = BenficiaryDataHandler()
    private init(){}

    var nationalities   : [NationalityResponse]  = []
    var banks           : [BankResponse]         = []
    var contractPath    : String                 = ""
    var selectedBenficiaryId : String            = ""
    var beneficiaryType      : CollectionPoint   = .all

    func clear(){
        selectedBenficiaryId  = ""
        beneficiaryType       = .all
    }
}
