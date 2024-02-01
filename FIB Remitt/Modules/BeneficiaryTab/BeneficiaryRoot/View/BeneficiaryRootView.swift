//
//  BeneficiaryRootView.swift
//  FIB Remitt
//
//  Created by Izak on 22/1/24.
//

import SwiftUI

struct BeneficiaryRootView: View {
    @State var isNotSelected : Bool = false
    @State var isSelected    : Bool = true
    @ObservedObject var vm = BeneficiaryViewModel()
    
    var body: some View {
        VStack(spacing:15){
            navigationBar
            topCollectionPointTypeContianer
            contextContainer
        }
        .padding(.horizontal)
        .background(Color.fr_background.ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $vm.goToNext) {vm.destinationView}
        .onAppear(){vm.viewWillAppearCalled()}
    }
}
//MARK: - VIEW COMPONENTS
extension BeneficiaryRootView{
    private var navigationBar : some View {
        FRNavigationBarView(leftView: nil, title: "Beneficiary", rightView: AnyView(FRTextButton(title: "+Add New", action: {self.addNewBtnPressed()})))
    }
    
    private var topCollectionPointTypeContianer : some View{
        ScrollView(.horizontal){
            HStack{
                ForEach(CollectionPoint.allCases, id: \.self) { item in
                    BeneficiaryTypeCellView(selected: vm.selectedCollectionPoint == item, title: item.title, icon: item.icon.isEmpty ? nil: item.icon)
                        .onTapGesture {
                            self.vm.selectedCollectionPoint = item
                        }
                }
            }}
    }
    
    private var contextContainer : some View{
        ZStack{
            ScrollView{
                if vm.selectedCollectionPoint == .all{
                    allBeneficiariesContainer
                }else if vm.selectedCollectionPoint == .bank_Transfer{
                    bankBeneficiariesContainer
                }else{
                    cashPickupContainer
                }
            }
        }
    }
    
    private var cashPickupContainer : some View{
        LazyVStack{
            ForEach(vm.cashPickUpBeneficiaries ?? [], id: \.self) { item in
                AccountInfoCellViewButton(selected: isNotSelected, title: item.fullName ?? "", subtitle1: "Phone \(item.phoneNumber ?? "")", subtitle2: item.address ?? "", icon: item.typeOfBeneficiary  == "Business" ? "business_ico": "personal_user_ico") {
                    BenficiaryDataHandler.shared.beneficiaryType = .cash_Pickup
                    BenficiaryDataHandler.shared.selectedBenficiaryId = item.id ?? ""
                    vm.navigateToBeneficiaryDetail()
                }
            }
        }
    }
    
    private var allBeneficiariesContainer : some View{
        LazyVStack{
            ForEach(vm.allBeneficiaries ?? [], id: \.self) { item in
                AccountInfoCellViewButton(selected: isNotSelected, title: item.title ?? "", subtitle1: "\(item.subTitle ?? "")", subtitle2: item.address ?? "", icon: item.accTypeIsBuiessness ?? false ? "business_ico": "personal_user_ico") {
                    BenficiaryDataHandler.shared.beneficiaryType = item.beneficiaryType
                    BenficiaryDataHandler.shared.selectedBenficiaryId = item.id ?? ""
                    vm.navigateToBeneficiaryDetail()
                }
            }
        }
    }
    
    private var bankBeneficiariesContainer : some View{
        LazyVStack{
            ForEach(vm.bankBeneficiaries ?? [], id: \.self) { item in
                AccountInfoCellViewButton(selected: isNotSelected, title: item.fullName ?? "", subtitle1: "A/C no: \(item.accountNumber ?? "")", subtitle2: item.address ?? "", icon: item.typeOfBeneficiary  == "Business" ? "business_ico": "personal_user_ico", action: {
                    BenficiaryDataHandler.shared.beneficiaryType = .bank_Transfer
                    BenficiaryDataHandler.shared.selectedBenficiaryId = item.id ?? ""
                    vm.navigateToBeneficiaryDetail()
                })
            }
        }
    }
}

//MARK: - ACTIONS
extension BeneficiaryRootView{
    private func addNewBtnPressed() {
        vm.navigateToSelectBeneficiarySheet()
    }
}
#Preview {
    BeneficiaryRootView()
}
