//
//  TransactionHistoryCellView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct TransactionHistoryCellView: View {
    @ObservedObject var vm = TransactionHistoryViewModel()
    let transaction: TransactionListContent
    var body: some View {
        FRVContainer (backgroundColor: .frForground){
            HStack (spacing:15){
                ZStack (alignment: .bottomTrailing){
                    Image("bank_ico")
                        .padding(14)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(Color.frBorder, lineWidth: 1)
                        }
                    Image("turkey")
                        .imageDefaultStyle()
                        .frame(width: 15)
                }
                
                VStack(alignment:.leading, spacing: 5){
                    HStack {
                        TextBaseMedium(text:"\(transaction.receiver?.fullName ?? "")", fg_color: .text_Regula)
                        Image("beneficiary_ico")
                            .imageDefaultStyle()
                            .frame(width: 15)
                    }
                    HStack {
                        TextSmallRegular(text:"Ref: \(transaction.transactionNumber ?? "")", fg_color: .textFade)
                        Image("beneficiary_ico")
                            .imageDefaultStyle()
                            .frame(width: 15)
                    }
                    TextSmallRegular(text: formatDateString(dateString: transaction.createdAt ?? "",  convertFormat:  "M/d/yyyy | h:mm a") ?? "", fg_color: .textFade)
                }
                Spacer()
                VStack(alignment:.trailing, spacing: 5){
                    HStack {
                        TextSmallRegular(text:"\(transaction.transaction?.amountToTransfer ?? 0) IQD", fg_color: .textRegula)
                        Image("beneficiary_ico")
                            .imageDefaultStyle()
                            .frame(width: 15)
                    }
                    HStack {
                        TextSmallRegular(text:"\(transaction.transaction?.amountReceivable ?? 0) TRY")
                        Image("beneficiary_ico")
                            .imageDefaultStyle()
                            .frame(width: 15)
                    }
                    Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                        TextSmallRegular(text: "Paid")
                            .padding(4)
                            .border(.green)
                            .cornerRadius(12)
                           
                    })
                        
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
