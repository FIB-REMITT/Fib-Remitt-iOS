//
//  HomePayViaFIBView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct HomePayViaFIBView: View {
    @ObservedObject var vm = HomeViewModel()
    var body: some View {
        VStack(spacing:20){
            navigationBar
            qrInfoContainer
            middleListContainer
            Spacer()
            bottomCancelButton

        }.onAppear{
            vm.getConfirmationByTransactionId(trxId: HomeDataHandler.shared.beneficiaryCollectionResponse?.transactionNumber ?? "")
        }
        .padding()
        .background(Color.frBackground.ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $vm.goToNext) {vm.destinationView}
    }
}

#Preview {
    HomePayViaFIBView()
}

//MARK: - VIEW COMPONENTS
extension HomePayViaFIBView{
    private var navigationBar : some View {
        FRNavigationBarView(title: "Pay via FIB", rightView: AnyView(FRBarButton(icon: "bell_ico", action: {self.notificationBtnPressed()})))
    }
    private var qrInfoContainer : some View{
        VStack {
            TextBaseRegular(text: "Scan bellow QR using FIB App", fg_color: .textMute)
            if let qrDataImg = vm.ConfirmationResponse?.qrCode?.getBase64StrQRcodeToImage(){
                Image(uiImage:qrDataImg )
                    .padding(12)
                    .background(Color.white)
                    .cornerRadius(12)
                
            }
           
            TextMediumRegular(text: vm.ConfirmationResponse?.readableCode ?? "", fg_color: .textMute)
                .padding(10)
                .background(.frForground)
                .cornerRadius(18)
        }
    }
    
    private var middleListContainer : some View{
        VStack{
            TextBaseRegular(text: "Already have FIB on your phone?", fg_color: .textMute).padding(.vertical,15)
            FRSimpleDirectedCellButton(title:"FIB Personal App",action: {navigateToWebApp(urlStr: vm.ConfirmationResponse?.personalAppLink ?? "")})
            FRSimpleDirectedCellButton(title:"FIB Business App",action: {navigateToWebApp(urlStr: vm.ConfirmationResponse?.businessAppLink ?? "")})
            FRSimpleDirectedCellButton(title:"FIB Corporate App",action: {navigateToWebApp(urlStr: vm.ConfirmationResponse?.corporateAppLink ?? "")})
        }
    }
    
    private var bottomCancelButton : some View{
        FRTextButton(title: "Cancel", color: .red) { cancelButtonPressed()}
    }
}

//MARK: - ACTIONS
extension HomePayViaFIBView{
    private func notificationBtnPressed() {}
    
    private func navigateToWebApp(urlStr:String){
        vm.navigateToWebAppLink(urlStr: urlStr)
    }
    
    
    private func navigateToSuccess(urlStr:String){
        //vm.navigateToSuccessfulView()
    }
    
    private func cancelButtonPressed(){
        loadView(view: FRBottomBarContainer())
    }

}
