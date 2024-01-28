//
//  HistoryRootView.swift
//  FIB Remitt
//
//  Created by Izak on 22/1/24.
//

import SwiftUI

struct HistoryRootView: View {
    
    @ObservedObject var vm = TransactionHistoryViewModel() // history view model
   
    var body: some View {
        VStack{
            navigationBar
            topFilterDropdown
            contextContainer
            Spacer()
        }
        .padding()
        .background(Color.frBackground.ignoresSafeArea())
        .navigationDestination(isPresented: $vm.goToNext) {vm.destinationView}
        .onAppear(perform: {
            vm.transactionListFetch()
        })
    }
}
//MARK: - VIEW COMPONENTS
extension HistoryRootView{
    private var navigationBar : some View {
        FRNavigationBarView(title: "Transfer History", rightView: AnyView(FRBarButton(icon: "bell_ico", action: {self.notificationBtnPressed()})))
    }
    private var topFilterDropdown : some View {
        HStack{
            FRTextDropDownButton(title: "Today", action: {self.filterBtnPressed()}).padding(.vertical,5)
            Spacer()
        }
    }
    private var contextContainer : some View{
        VStack{
            TransactionHistoryCellView()
            TransactionHistoryCellView()
            TransactionHistoryCellView()
            TransactionHistoryCellView()
        }
    }
}

//MARK: - ACTIONS
extension HistoryRootView{
    private func notificationBtnPressed() {

    }
    private func filterBtnPressed() {

    }
}
#Preview {
    HistoryRootView()
}
