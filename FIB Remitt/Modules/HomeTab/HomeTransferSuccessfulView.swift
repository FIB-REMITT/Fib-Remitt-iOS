//
//  HomeTransferSuccessfulView.swift
//  FIB Remitt
//
//  Created by Izak on 23/1/24.
//

import SwiftUI

struct HomeTransferSuccessfulView: View {
    let width = UIScreen.main.bounds.width
    var body: some View {
        VStack(spacing: 20){
            Spacer()
            Image("success_tick")
                .imageDefaultStyle()
                .frame(width: width * 0.25)
            TextH4Medium(text: "Congratulation!", fg_color: .textRegula)
            TextBaseRegular(text: "Your remittance has been submitted for processing. You'll be updated regularly about the progress of the transfer.", fg_color: .textFade)
                .padding(.horizontal)
                .multilineTextAlignment(.center)

            VStack(spacing:10){
                FRVerticalBtn(title:"Back To Home", btnColor: .primary500) {}
                    .frame(width: width * 0.4)
                Button(action: {
                }, label: {
                    TextBaseMedium(text: "Track My Transfer", fg_color: .primary500)
                        .padding(12)
                        .padding(.horizontal, 6)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color.primary500, lineWidth: 1) }
                })
            }.padding()
            Spacer()
        }.background(Color.fr_background.ignoresSafeArea())
    }
}

#Preview {
    HomeTransferSuccessfulView()
}
