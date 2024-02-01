//
//  HomeEnum.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 1/2/24.
//

import Foundation

enum Language:String, CaseIterable{
    case Eng
    case Kur

    var title: String{
        switch self {
        case .Eng   : return "Eng"
        case .Kur   : return "Kur"
        }
    }
}
