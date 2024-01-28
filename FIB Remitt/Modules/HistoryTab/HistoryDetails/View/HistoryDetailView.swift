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
    @State var benDetails : Bool = false
    @State var traSummary : Bool = false
    
    var body: some View {
        VStack(spacing: 12){
            navigationBar
            SimpleHInfoCellView(title: "Delivery Method", info: "Bank Transfer")
            SimpleHInfoCellView(title: "Purpose", info:  "")
            
            FRVContainer (spacing: 12,backgroundColor: .fr_forground){
                HStack{
                    TextBaseMedium(text: "Beneficiary Details", fg_color: .text_Mute)
                    Spacer()
                    Image(systemName: benDetails ? "chevron.up" : "chevron.down")
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation{
                        benDetails.toggle()
                    }
                }
                
                if benDetails{
                    VStack(spacing: 12){
                        
                        SimpleHColonInfoView(title: "Name", info:  "")
                        SimpleHColonInfoView(title: "Bank Name", info: "Ziraat Bank")
                        SimpleHColonInfoView(title: "Account No.", info: "124 458 458 856")
                        SimpleHColonInfoView(title: "Ref No.", info: "02748869")
                        SimpleHColonInfoView(title: "Type", info: "Personal")
                        SimpleHColonInfoView(title: "Relation", info: "Uncle")
                        SimpleHColonInfoView(title: "Phone", info: "+90 212 555 1212")
                        SimpleHColonInfoView(title: "Address", info: "Ankara, Turkey")
                    }
                }
            }
            
            FRVContainer (spacing: 12,backgroundColor: .fr_forground){
                HStack{
                    TextBaseMedium(text: "Transfer Summary", fg_color: .text_Mute)
                    Spacer()
                    Image(systemName: traSummary ? "chevron.up" : "chevron.down")
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation{
                        traSummary.toggle()
                    }
                }
                
                if traSummary{
                    VStack(alignment: .leading,spacing: 12){
                        Text("10/1/2023 | 10:00 PM")
                            .foregroundColor(Color.text_Mute)
                            .font(UI.FRAppDesignedFont(style: .smallRegular))
                        
                        SimpleHInfoRegularView(title: "Amount to transfer", info: "125,000 IQD")
                        SimpleHInfoRegularView(title: "Service charge", info: "+ 5,000 IQD")
                        Divider()
                        SimpleHModInfoView(title: "Total payble", info: "130,000 IQD",fontStyle: .titleBold)
                        SimpleHModInfoView(title: "Recipient gets", info: "2,875 TRY", textColor: Color.primary500, fontStyle: .allBold)
                    }
                }
            }
            
            //            FRVContainer (spacing: 12,alignment:.leading,backgroundColor: .fr_forground){
            //                TextBaseMedium(text: "Progress", fg_color: .text_Mute)
            //
            //                HStack(spacing: 6){
            //                    VStack(alignment: .trailing, spacing: 5){
            //                        Text("Pending")
            //                        .foregroundColor(Color.warning_regular)
            //                        .font(UI.FRAppDesignedFont(style: .smallRegular))
            //                        .padding(.horizontal, 7)
            //                        .padding(.vertical, 1)
            //                        .background(Color.warning_regular.opacity(0.1))
            //                        .overlay(RoundedRectangle(cornerRadius: 100).stroke(Color.warning_regular, lineWidth: 1))
            //
            //                        //9th March 2023 | 10:00 PM
            //
            //                        Text("9th March 2023 | 10:00 PM")
            //                        .foregroundColor(Color.text_Mute)
            //                        .font(UI.FRAppDesignedFont(style: .smallRegular))
            //                    }
            //
            //                    Image("pending")
            //                        .imageDefaultStyle()
            //                        .frame(width:16, height: 16)
            //                        .padding(4)
            //                        .background(Color.warning_regular.opacity(0.1))
            //                        .cornerRadius(100)
            //
            //                }
            //            }
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
    HistoryDetailView(id: "")
}
