//
//  TransactionHistoryCellView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct TransactionHistoryCellView: View {
    @ObservedObject var vm = TransactionHistoryViewModel()
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
                        TextBaseMedium(text:"John Doe", fg_color: .textRegula)
                        Image("beneficiary_ico")
                            .imageDefaultStyle()
                            .frame(width: 15)
                    }
                    HStack {
                        TextSmallRegular(text:"Ref: 02748869", fg_color: .textFade)
                        Image("beneficiary_ico")
                            .imageDefaultStyle()
                            .frame(width: 15)
                    }
                    TextSmallRegular(text:"10/1/2023 | 10:00 PM", fg_color: .textFade)
                }
                Spacer()
                VStack(alignment:.trailing, spacing: 5){
                    HStack {
                        TextSmallRegular(text:"125,000 IQD", fg_color: .textRegula)
                        Image("beneficiary_ico")
                            .imageDefaultStyle()
                            .frame(width: 15)
                    }
                    HStack {
                        TextSmallRegular(text:"2,875 TRY")
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
        TransactionHistoryCellView()
    }
}
