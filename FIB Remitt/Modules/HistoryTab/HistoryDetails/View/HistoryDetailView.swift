//
//  HistoryDetailView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct HistoryDetailView: View {
    @ObservedObject var vm = TransactionHistoryViewModel()
    var id : String
    var body: some View {
        VStack(spacing: 12){
            navigationBar
            SimpleHInfoCellView(title: "Delivery Method", info: "Bank Transfer")
            SimpleHInfoCellView(title: "Purpose", info: "Family Support")
            FRSimpleDropDownButton(title: "Beneficiary Details",bg_color: .fr_forground, isContextMedium: true)
            FRSimpleDropDownButton(title: "Transfer Summary",bg_color: .fr_forground, isContextMedium: true)

            Spacer()
        }.padding()
            .background(Color.fr_background.ignoresSafeArea())
            .navigationBarHidden(true)
            .onAppear(perform: {
                vm.transactionDetailsFetch(transactionNumber: id)
            })
    }
}
//MARK: - VIEW COMPONENTS
extension HistoryDetailView{
    private var navigationBar : some View {
        FRNavigationBarView(title: "History Details", rightView: AnyView(FRBarButton(icon: "bell_ico", action: {self.notificationBtnPressed()})))
    }
}

//MARK: - ACTIONS
extension HistoryDetailView{
    private func notificationBtnPressed() {
    }
}
#Preview {
    HistoryDetailView( id: "")
}
