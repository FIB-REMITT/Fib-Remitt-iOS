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
            Spacer()
        }
        .padding()
        .background(Color.fr_background.ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $vm.goToNext) {vm.destinationView}
        .onAppear(){vm.viewWillAppearCalled()}
    }
}
//MARK: - VIEW COMPONENTS
extension BeneficiaryRootView{
    private var navigationBar : some View {
        FRNavigationBarView(title: "Beneficiary", rightView: AnyView(FRTextButton(title: "+Add New", action: {self.addNewBtnPressed()})))
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
        VStack{
            AccountInfoCellView(selected: isNotSelected)
            AccountInfoCellView(selected: isNotSelected)
            AccountInfoCellView(selected: isNotSelected)
            AccountInfoCellView(selected: isNotSelected)
        }.onTapGesture {
            vm.navigateToBeneficiaryDetail()
        }
    }
}

//MARK: - ACTIONS
extension BeneficiaryRootView{
    private func addNewBtnPressed() {
        vm.navigateToEditBankBeneficiary()
    }
}
#Preview {
    BeneficiaryRootView()
}
