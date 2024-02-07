//
//  TransactionHistoryCellView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI
import UIKit

struct TransactionHistoryCellView: View {
    @ObservedObject var vm = TransactionHistoryViewModel()
    @State var tempColor = Color.text_Mute
    let transaction: TransactionListContent
    var body: some View {
        FRVContainer (backgroundColor: .frForground){
            HStack (spacing:15){
                ZStack (alignment: .bottomTrailing){
                    if transaction.collectionPoint == "BANK"{
                        Image("bank_ico")
                        .padding(14)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(Color.frBorder, lineWidth: 1)
                            .frame(width: 50, height: 50)
                        }
                    }else{
                        TextH4Medium(text: String(transaction.receiver?.fullName?.prefix(1) ?? ""), fg_color: .primary500 )
                            .padding(14)
                            .overlay {
                                RoundedRectangle(cornerRadius: 25)
                                .strokeBorder(Color.frBorder, lineWidth: 1)
                                .frame(width: 50, height: 50)
                                
                            }
                    }
                    
//                    Image("bank_ico")
//                        .padding(14)
//                        .overlay {
//                            RoundedRectangle(cornerRadius: 25)
//                            .strokeBorder(Color.frBorder, lineWidth: 1)
//                        }
//                    Image("turkey")
//                        .imageDefaultStyle()
//                        .frame(width: 15)
                }
                
                VStack(alignment:.leading, spacing: 5){
                    HStack {
                        TextBaseMedium(text:"\(transaction.receiver?.fullName ?? "")", fg_color: .text_Regula)
                        Image(transaction.collectionPoint == "BANK" ? "bank": "personal")
                            .imageDefaultStyle()
                            .frame(width: 12, height: 12)
                            .padding(4)
                            .background(Color.secondary_10)
                            .cornerRadius(100)
                        
                    }
                    HStack {
                        TextSmallRegular(text:"Ref: \(transaction.transactionNumber ?? "")", fg_color: .textFade)
                        Image("copy")
                            .imageDefaultStyle()
                            .frame(width: 10, height: 10)
                            .padding(4)
                            .background(Color.color_info_10)
                            .cornerRadius(100)
                            .onTapGesture {
                                UIPasteboard.general.string = transaction.transactionNumber
                                showToast(message: "Text Copied")
                            }
                        
                    }
                    TextSmallRegular(text: formatDateString(dateString: transaction.createdAt ?? "",  convertFormat:  "M/d/yyyy | h:mm a") ?? "", fg_color: .textFade)
                }
                Spacer()
                VStack(alignment:.trailing, spacing: 5){
                    HStack {
                        TextSmallRegular(text:"\(transaction.transaction?.amountToTransfer ?? 0) IQD", fg_color: .textRegula)
                        Image("red-arrow-up")
                            .imageDefaultStyle()
                            .frame(width: 12, height: 12)
                    }
                    HStack {
                        TextSmallRegular(text:"\(roundAmount(doubleValue: transaction.transaction?.amountReceivable ?? 0, format: "%.4f")) TRY")
                        Image("green-arrow-down")
                            .imageDefaultStyle()
                            .frame(width: 12, height: 12)
                    }
                    //Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    TextSmallRegular(
                        text: transaction.status ?? "Unknown",
                        fg_color: tempColor)
                        .padding(.horizontal,4)
                        .padding(.vertical, 2)
                        .background(tempColor.opacity(0.1))
                        .overlay(RoundedRectangle(cornerRadius: 100).stroke(tempColor, lineWidth: 1))
                        
                }

            }
            .onAppear{
                if transaction.status == "Paid" {
                    tempColor = Color.green
                } else if transaction.status == "Pending_Approval" {
                    tempColor = Color.warning_regular
                } else {
                    tempColor = Color.red
                }
            }
        }
       
    }
    
  
}

#Preview {
    ZStack{
        Color.fr_background.ignoresSafeArea()
        TransactionHistoryCellView(transaction: TransactionListContent(transactionNumber: "", receiver: Receiver(fullName: "", phoneNumber: "", nationality: "", address: "", gender: "", typeOfBeneficiary: "", relationship: "", accountNumber: "", bankName: ""), collectionPoint: "", purposeTitle: "", transaction: Transaction(fromCurrency: "", amountToTransfer: 0, toCurrency: "", totalPayable: 0, charge: 0, amountReceivable: 0.0), status: "", createdAt: "", updatedAt: ""))
    }
}
