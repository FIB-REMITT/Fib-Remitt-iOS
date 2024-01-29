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
        ScrollView {
            VStack(spacing: 12){
                navigationBar
                SimpleHInfoCellView(title: "Delivery Method", info: "Bank Transfer")
                SimpleHInfoCellView(title: "Purpose", info:  "Family Support")
                
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
                
                FRVContainer (spacing: 12,backgroundColor: .fr_forground){
                    VStack(alignment: .center){
                        HStack {
                            TextBaseMedium(text: "Progress", fg_color: .text_Mute)
                            Spacer()
                        }
                            VStack(spacing: 20){
                                ProgressComponentWithDivider(status: "Pending", timeDat: "9th March 2023 | 10:00 PM", iconName: "pending", cellColor: Color.warning_regular, alignmentStyle: .left)
                                
                                ProgressComponentWithDivider(status: "Hold", timeDat: "9th March 2023 | 10:00 PM", iconName: "pause", cellColor: Color.red, alignmentStyle: .right)
                                
                                ProgressComponent(status: "Hold", timeDat: "9th March 2023 | 10:00 PM", iconName: "pause", cellColor: Color.red, alignmentStyle: .right)
                                
//                                ProgressComponent(status: "Approved", timeDat: "9th March 2023 | 10:00 PM", iconName: "approved", cellColor: Color.green, alignmentStyle: .right)
//                                
//                                ProgressComponent(status: "Canceled", timeDat: "9th March 2023 | 10:00 PM", iconName: "close", cellColor: Color.red, alignmentStyle: .right)
//                                
//                                ProgressComponent(status: "Paid", timeDat: "9th March 2023 | 10:00 PM", iconName: "paid", cellColor: Color.green, alignmentStyle: .left)
                            }
                            .frame(maxWidth: 275)
                    }
                }
                Spacer()
            }.padding()
                .navigationBarHidden(true)
                .onAppear(perform: {
                    vm.transactionDetailsFetch(transactionNumber: id)
            })
        }
        .background(Color.fr_background.ignoresSafeArea())
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
enum ProgressComponentAlignment {
    case left
    case right
}
struct ProgressComponentWithDivider: View {
    var status: String
    var timeDat: String
    var iconName: String
    var cellColor = Color.warning_regular
    var alignmentStyle: ProgressComponentAlignment
    var body: some View {
        VStack{
            ZStack(alignment: .center){
                HStack{
                    Divider()
                        .frame(width: 1)
                        .frame(height: 40)
                        .overlay(Color.gray.opacity(0.5))
                        .padding(.bottom, -150)
                }
                ProgressComponent(status: status, timeDat: timeDat, iconName: iconName, cellColor: cellColor, alignmentStyle: alignmentStyle)
                
            }
        }
    }
}

struct ProgressComponent: View {
    var status: String
    var timeDat: String
    var iconName: String
    var cellColor = Color.warning_regular
    var alignmentStyle: ProgressComponentAlignment
    var body: some View {
        HStack(spacing: 6) {
            if alignmentStyle == .left {
                VStack(alignment: .trailing, spacing: 5) {
                    Text(status)
                        .foregroundColor(cellColor)
                        .font(UI.FRAppDesignedFont(style: .smallRegular))
                        .padding(.horizontal, 7)
                        .padding(.vertical, 1)
                        .background(cellColor.opacity(0.1))
                        .overlay(RoundedRectangle(cornerRadius: 100).stroke(cellColor, lineWidth: 1))
                    
                    Text(timeDat)
                        .foregroundColor(Color.text_Mute)
                        .font(UI.FRAppDesignedFont(style: .smallRegular))
                }
            }
            if alignmentStyle == .right{
                Spacer()
            }
            Image(iconName)
                .imageDefaultStyle()
                .frame(width:16, height: 16)
                .padding(4)
                .background(cellColor.opacity(0.1))
                .background(Color.white)
                .cornerRadius(100)
            
            if alignmentStyle == .right {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(status)
                            .foregroundColor(cellColor)
                            .font(UI.FRAppDesignedFont(style: .smallRegular))
                            .padding(.horizontal, 7)
                            .padding(.vertical, 1)
                            .background(cellColor.opacity(0.1))
                            .overlay(RoundedRectangle(cornerRadius: 100).stroke(cellColor, lineWidth: 1))
                        
                        Text(timeDat)
                            .foregroundColor(Color.text_Mute)
                            .font(UI.FRAppDesignedFont(style: .smallRegular))
                    }
            }
            
            if alignmentStyle == .left {
                Spacer()
            }
        }
    }
}
