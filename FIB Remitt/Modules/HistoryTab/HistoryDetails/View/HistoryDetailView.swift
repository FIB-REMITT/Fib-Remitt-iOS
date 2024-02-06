//
//  HistoryDetailView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct HistoryDetailView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var vm = TransactionHistoryViewModel()
    var id : String
    @State var benDetails : Bool = false
    @State var traSummary : Bool = false
    var fromPaymentSuccess:Bool = false
    
    let screenWidth = UIScreen.main.bounds.width
    
    var body: some View {
        ScrollView {
            VStack(spacing: 12){
                navigationBar
                SimpleHInfoCellView(title: "Delivery Method", info: vm.transactionDetails?.collectionPoint ?? "")
                SimpleHInfoCellView(title: "Purpose", info:  vm.transactionDetails?.purposeTitle ?? "")
                
                FRVContainer (spacing: 12,backgroundColor: .fr_forground){
                    HStack{
                        TextBaseMedium(text: "Beneficiary Details", fg_color: .text_Mute)
                        Spacer()
                        Image(systemName: benDetails ? "chevron.up" : "chevron.down")
                            .imageDefaultStyle()
                            .foregroundColor(Color.text_Mute)
                            .frame(width: 16, height: 8)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation{
                            benDetails.toggle()
                        }
                    }
                    
                    if benDetails{
                        VStack(spacing: 12){
                            SimpleHColonInfoView(title: "Name", info:  vm.transactionDetails?.receiver?.fullName ?? "")
                            SimpleHColonInfoView(title: "Bank Name", info: vm.transactionDetails?.receiver?.bankName ?? "")
                            SimpleHColonInfoView(title: "Account No.", info: vm.transactionDetails?.receiver?.accountNumber ?? "")
                            SimpleHColonInfoView(title: "Ref No.", info: vm.transactionDetails?.transactionNumber ?? "")
                            SimpleHColonInfoView(title: "Type", info: vm.transactionDetails?.receiver?.typeOfBeneficiary ?? "")
                            SimpleHColonInfoView(title: "Relation", info: vm.transactionDetails?.receiver?.relationship ?? "-")
                            SimpleHColonInfoView(title: "Phone", info: vm.transactionDetails?.receiver?.phoneNumber ?? "")
                            SimpleHColonInfoView(title: "Address", info: vm.transactionDetails?.receiver?.address ?? "")
                        }
                    }
                }
                
                FRVContainer (spacing: 12,backgroundColor: .fr_forground){
                    HStack{
                        TextBaseMedium(text: "Transfer Summary", fg_color: .text_Mute)
                        Spacer()
                        Image(systemName: traSummary ? "chevron.up" : "chevron.down")
                            .imageDefaultStyle()
                            .frame(width: 16, height: 8)
                            .foregroundColor(Color.text_Mute)
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation{
                            traSummary.toggle()
                        }
                    }
                    
                    if traSummary{
                        VStack(alignment: .leading,spacing: 12){
                            Text(formatDateString(incomingFormate: "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",dateString: vm.transactionDetails?.createdAt ?? "", convertFormat: "M/d/yyyy | h:mm a") ?? "")
                                .foregroundColor(Color.text_Mute)
                                .font(UI.FRAppDesignedFont(style: .smallRegular))
                            
                            SimpleHInfoRegularView(title: "Amount to transfer", info: "\(vm.transactionDetails?.transaction?.amountToTransfer ?? 0.0) " + (vm.transactionDetails?.transaction?.fromCurrency ?? ""))
                            SimpleHInfoRegularView(title: "Service charge", info: "\(vm.transactionDetails?.transaction?.charge ?? 0.0) "+(vm.transactionDetails?.transaction?.fromCurrency ?? ""))
                            Divider()
                            SimpleHModInfoView(title: "Total payable", info: "\(vm.transactionDetails?.transaction?.totalPayable ?? 0.0) ",fontStyle: .titleBold)
                            SimpleHModInfoView(title: "Recipient gets", info: "\(vm.transactionDetails?.transaction?.amountReceivable ?? 0.0) "+(vm.transactionDetails?.transaction?.toCurrency ?? ""), textColor: Color.primary500, fontStyle: .allBold)
                        }
                    }
                }
                
                if vm.transactionDetails?.progress != nil && vm.transactionDetails?.progress?.count != 0 {
                    FRVContainer (spacing: 12,backgroundColor: .fr_forground){
                        VStack(alignment: .center){
                            HStack {
                                TextBaseMedium(text: "Progress", fg_color: .text_Mute)
                                Spacer()
                            }
                                VStack(spacing: 20){
                                  
                                    if let progresses = vm.transactionDetails?.progress {
                                        let sortedProgress = progresses.sorted { (progress1, progress2) in
                                            if let state1 = Int(progress1.state ?? "0"), let state2 = Int(progress2.state ?? "0") {
                                                        if state1 == state2 {
                                                            // If states are equal, compare by createdDate
                                                            if let date1 = progress1.createdAt, let date2 = progress2.createdAt {
                                                                return date1 < date2
                                                            }
                                                        }
                                                        return state1 > state2
                                                    }
                                                    return false // Handle cases where conversion to Int fails
                                                }
                                        
                                        ForEach(sortedProgress.indices, id: \.self) { index in
                                            let progressData = progresses[index]
                                          
                                            let icon =  viewForProgressState(progressData: progressData)
                                            
                                            let side : ProgressComponentAlignment = (index % 2 == 0) ? .left : .right
                                            let textColor = viewForProgressTextColor(progressData: progressData)
                                            
                                            ProgressComponentWithDivider(status: icon, timeDat:formatDateString(incomingFormate: "yyyy-MM-dd'T'HH:mm:ss.SSSSSS",dateString: progressData.createdAt ?? "", convertFormat: "d MMMM yyyy | h:mm a") ?? "", iconName: icon, cellColor: textColor, alignmentStyle: side)
                                           //
                                        }
                                    }
                                }
                        }
                        .padding(.vertical, 10)
                    }
                    Spacer()
                }

            }.padding()
                .navigationBarHidden(true)
                .onAppear(perform: {
                    vm.transactionDetailsFetch(transactionNumber: id)
            })
        }
        .background(Color.fr_background.ignoresSafeArea())
    }
    private func viewForProgressState(progressData:DetailsProgress) -> String {
           switch progressData.state {
           case "1":
               return "Pending"
           case "2":
               return "Approved"
           case "3":
               return "Paid"
           case "4":
               return "Hold"
           case "5":
               return "Canceled"
           default:
               return ""
           }
       }
    
    
    private func viewForProgressTextColor(progressData:DetailsProgress) -> Color {
           switch progressData.state {
           case "1":
               return Color.warning_regular
           case "2":
               return Color.green
           case "3":
               return Color.green
           case "4":
               return Color.red
           case "5":
               return Color.red
           default:
               return Color.black
           }
       }
    
//    ProgressComponentWithDivider(status: "Pending", timeDat: "9th March 2023 | 10:00 PM", iconName: "pending", cellColor: Color.warning_regular, alignmentStyle: .left)
//    
//    ProgressComponentWithDivider(status: "Hold", timeDat: "9th March 2023 | 10:00 PM", iconName: "pause", cellColor: Color.red, alignmentStyle: .right)
//    
//    ProgressComponent(status: "Hold", timeDat: "9th March 2023 | 10:00 PM", iconName: "pause", cellColor: Color.red, alignmentStyle: .right)
//    
////                                ProgressComponent(status: "Approved", timeDat: "9th March 2023 | 10:00 PM", iconName: "approved", cellColor: Color.green, alignmentStyle: .right)
////
////                                ProgressComponent(status: "Canceled", timeDat: "9th March 2023 | 10:00 PM", iconName: "close", cellColor: Color.red, alignmentStyle: .right)
////
////                                ProgressComponent(status: "Paid", timeDat: "9th March 2023 | 10:00 PM", iconName: "paid", cellColor: Color.green, alignmentStyle: .left)
}
//MARK: - VIEW COMPONENTS
extension HistoryDetailView{
    private var navigationBar : some View {
        FRNavigationBarView(leftView: AnyView(FRBarButton(icon: "back_arrow",action: {
            if  fromPaymentSuccess{
                loadView(view: FRBottomBarContainer())
            }else{
                presentationMode.wrappedValue.dismiss()
            }
           
        })),title: "History Details", rightView: AnyView(FRBarButton(icon: "bell_ico", action: {self.notificationBtnPressed()})))
    }
}

//MARK: - ACTIONS
extension HistoryDetailView{
    private func notificationBtnPressed() {showToast(message: "No notification found!")}
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
                .opacity(alignmentStyle == .right ? 0 : 1)

            Image(iconName)
                .imageDefaultStyle()
                .frame(width:16, height: 16)
                .padding(4)
                .background(cellColor.opacity(0.1))
                .background(Color.white)
                .cornerRadius(100)
            
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
                }.opacity(alignmentStyle == .left ? 0 : 1)
        }
    }
}
