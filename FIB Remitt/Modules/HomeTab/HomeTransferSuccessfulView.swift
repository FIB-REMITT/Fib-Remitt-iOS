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
        ZStack{
            Color.fr_background.ignoresSafeArea()
            VStack(spacing: 20){
                Spacer()
                tickIcon
                topTitle
                messageDescription
                actionButtonContainer
                Spacer()
            }
        }.navigationBarHidden(true)
    }
}

//MARK: - VIEW COMPONENTS
extension HomeTransferSuccessfulView{
    private var tickIcon : some View{
        Image("success_tick")
            .imageDefaultStyle()
            .frame(width: width * 0.25)
    }
    
    private var topTitle : some View{
        TextH4Medium(text: "Congratulation!", fg_color: .textRegula)
    }
    
    private var messageDescription : some View{
        TextBaseRegular(text: "Your remittance has been submitted for processing. You'll be updated regularly about the progress of the transfer.", fg_color: .textFade)
            .padding(.horizontal)
            .multilineTextAlignment(.center)
    }
    private var actionButtonContainer : some View{
        VStack(spacing:10){
            FRVerticalBtn(title:"Back To Home", btnColor: .primary500) {self.backToHomeBtnPressed()}
                .frame(width: width * 0.4)
            
            Button(action: { self.trackMyTransferButtonPressed() }, label: {
                TextBaseMedium(text: "Track My Transfer", fg_color: .primary500)
                    .padding(12)
                    .padding(.horizontal, 6)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .strokeBorder(Color.primary500, lineWidth: 1) }
            })
        }.padding()

    }

}

//MARK: - ACTIONS
extension HomeTransferSuccessfulView{
    private func backToHomeBtnPressed() {
        loadView(view: FRBottomBarContainer())
    }
    private func trackMyTransferButtonPressed() {}
}

#Preview {
    HomeTransferSuccessfulView()
}
