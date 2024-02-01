//
//  HomeTransferSuccessfulView.swift
//  FIB Remitt
//
//  Created by Izak on 23/1/24.
//

import SwiftUI

struct HomeTransferSuccessfulOrFailedView: View {
    
    @ObservedObject var vm = HomeViewModel()
    let width = UIScreen.main.bounds.width
    var isSuccess : Bool = true
    var trxId : String = ""
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
        .navigationDestination(isPresented: $vm.goToNext, destination: { vm.destinationView })
    }
}

//MARK: - VIEW COMPONENTS
extension HomeTransferSuccessfulOrFailedView{
    private var tickIcon : some View{
        Image(isSuccess ? "success_tick" : "failed_cross")
            .imageDefaultStyle()
            .frame(width: width * 0.25)
    }
    
    private var topTitle : some View{
        TextH4Medium(text: isSuccess ? "Congratulation!" : "Failed" , fg_color: .textRegula)
    }
    
    private var messageDescription : some View{
        TextBaseRegular(text: isSuccess ? "Your remittance has been submitted for processing. You'll be updated regularly about the progress of the transfer." : "Request Timeout", fg_color: .textFade)
            .padding(.horizontal)
            .multilineTextAlignment(.center)
    }
    private var actionButtonContainer : some View{
        VStack(spacing:10){
            if isSuccess == false{
                FRVerticalBtn(title:"Track My Transfer", btnColor: .primary500) { self.trackMyTransferButtonPressed()}
                    .frame(width: width * 0.4)
                
                Button(action: { self.backToHomeBtnPressed() }, label: {
                    TextBaseMedium(text: "Home", fg_color: .primary500)
                        .padding(12)
                        .padding(.horizontal, 6)
                        .frame(width: width * 0.4)
                        .overlay {
                            RoundedRectangle(cornerRadius: 20)
                                .strokeBorder(Color.primary500, lineWidth: 1) }
                })
            }else{
                FRVerticalBtn(title:"Home", btnColor: .primary500) { self.backToHomeBtnPressed()}
                    .frame(width: width * 0.4)
            }
            
            
        }.padding()

    }

}

//MARK: - ACTIONS
extension HomeTransferSuccessfulOrFailedView{
    private func backToHomeBtnPressed() {
        loadView(view: FRBottomBarContainer())
    }
    private func trackMyTransferButtonPressed() {
        vm.navigateToHistoryDetails(trxID: self.trxId)
    }
}

#Preview {
    HomeTransferSuccessfulOrFailedView()
}
