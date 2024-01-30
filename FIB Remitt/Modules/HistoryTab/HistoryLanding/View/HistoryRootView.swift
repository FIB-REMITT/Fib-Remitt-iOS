//
//  HistoryRootView.swift
//  FIB Remitt
//
//  Created by Izak on 22/1/24.
//

import SwiftUI

struct HistoryRootView: View {
    
    @ObservedObject var vm = TransactionHistoryViewModel() // history view model
    //@State var selectedFilterValue: String = "All"
   @State var pageNo = 0
    var body: some View {
        VStack{
            navigationBar
            ScrollView{
                topFilterDropdown
                contextContainer
            }
        }
        .padding()
        .background(Color.frBackground.ignoresSafeArea())
        .navigationDestination(isPresented: $vm.goToNext) {vm.destinationView}
        .onAppear(perform: {
            
           initialDataAll()
        })
    }
    
    func initialDataAll(from:String = "",to:String = ""){
        vm.transactionHistoryDataOnly = []
        pageNo = 0
        transactionListApi(from: from, to:to)
       
    }
    
    //MARK: - API CALL
    func transactionListApi(from:String = "",to:String = ""){
        vm.transactionListFetch(page: self.pageNo,from: from,to: to)
    }
    
}
//MARK: - VIEW COMPONENTS
extension HistoryRootView{
    private var navigationBar : some View {
        FRNavigationBarView(title: "Transfer History", rightView: AnyView(FRBarButton(icon: "bell_ico", action: {self.notificationBtnPressed()})))
    }
    private var topFilterDropdown : some View {
        HStack{
            FRTextDropDownButton(title: vm.selectedFilterValue, action: {self.filterBtnPressed()}).padding(.vertical,5)
            Spacer()
        }
    }
    private var contextContainer : some View{
        VStack{
            
            ForEach(vm.transactionHistoryDataOnly) { transactionData in
                       TransactionHistoryCellView(transaction: transactionData)
                    
                    .onTapGesture {
                        vm.navigateToTransactionDetails(transactionNumber: transactionData.transactionNumber ?? "")
                     }
                   }
        }
    }
}

//MARK: - ACTIONS
extension HistoryRootView{
    private func notificationBtnPressed() {}
    private func filterBtnPressed() {
        showSheet(view: AnyView(FilterOptionsView(selectedValue: vm.selectedFilterValue) { selectedItem in
            self.vm.selectedFilterValue = selectedItem
        }))
    }
}

#Preview {
    HistoryRootView()
}
