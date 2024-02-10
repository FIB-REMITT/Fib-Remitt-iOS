//
//  AppSceneEnum.swift
//  FIB Remitt
//
//  Created by Izak on 11/2/24.
//

import SwiftUI


enum HomeFlowScene:String, Hashable{
    case homeRoot
    case beneficiarySelection
    case beneficiarySummary
    case payViaFIB
    case transactionSuccessful
    
    var view: AnyView{
        switch self {
        case .homeRoot: return AnyView(HomeRootView())
        case .beneficiarySelection:
            return AnyView(HomeSelectBeneficiaryView())
        case .beneficiarySummary:
            return AnyView(HomeBeneficiarySummaryView())
        case .payViaFIB:
            return AnyView(FibPaymentCheckView())
        case .transactionSuccessful:
            return AnyView(HomeTransferSuccessfulOrFailedView())
        }
    }
}

enum BeneficiaryFlowScene:String, Hashable{
    case beneficiaryRoot
    case beneficiaryDetail
    case selectBeneficiaryType
    case editBankBeneficiary
    case editCashPickupBeneficiary
    case addBeneficiarySuccessfull
    
    var view: AnyView{
        switch self {
        case .beneficiaryRoot:
            return AnyView(BeneficiaryRootView())
        case .beneficiaryDetail:
            return AnyView(BeneficiaryDetailView())
        case .selectBeneficiaryType:
            return AnyView(SelectBeneficiaryTypeBottomSheet())
        case .editBankBeneficiary:
            return AnyView(EditBeneficiaryBankView())
        case .editCashPickupBeneficiary:
            return AnyView(EditBeneficiaryCashPickupView())
        case .addBeneficiarySuccessfull:
            return AnyView(BeneficiaryAddSuccessfulView())
        }
    }
}

enum HistoryFlowScene: String, Hashable, RawRepresentable{
    
    case historyRoot
    case historyDetail
}
