//
//  HomePayViaFIBView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct HomePayViaFIBView: View {
    @ObservedObject var vm = HomeViewModel()
    @State private var secondsRemaining = 300
    @State private var isLoading = false
    @State private var navigateToFailedView = false
    @State private var areTimersRunning = true
    
    private let timerPublisher = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack(spacing:20){
            navigationBar
            qrInfoContainer
            middleListContainer
            TextH6Medium(text: "Waiting for vaildate the transaction", fg_color: .primary500)
            TextBaseRegular(text: "Ramaining: \(secondsRemaining/60) minutes \(secondsRemaining%60) seconds", fg_color: .primary500)
                .padding()
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .primary500))
                        .scaleEffect(2.0) // Increase the scale factor to make it bigger
                        .padding()
            }
            Spacer()
            bottomCancelButton
            
        }.onAppear{
            startTimers()
            vm.getConfirmationByTransactionId(trxId: HomeDataHandler.shared.beneficiaryCollectionResponse?.transactionNumber ?? "")
        }
        .onDisappear {
            stopTimers()
        }
        .onReceive(timerPublisher, perform: { _ in
            if areTimersRunning {
                paymentCheckApiCall()
                if vm.PaymentConfirmationResponse?.status == true{
                    navigateToSuccessDialogue()
                }
            }
        })
        .onChange(of: vm.PaymentConfirmationResponse) { value in
            if value?.status == true{
                navigateToSuccessDialogue()
            }
        }
        .padding()
        .background(Color.frBackground.ignoresSafeArea())
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $vm.goToNext) {vm.destinationView}
    }
    
    func navigateToSuccessDialogue(){
       
        isLoading = false
        areTimersRunning = false
        vm.navigateToSuccessfulView()
    }

    func startTimers() {
        isLoading = true
      
        areTimersRunning = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if secondsRemaining > 0 && (secondsRemaining/5) > 0 {
                secondsRemaining -= 1
            } else {
                timer.invalidate()
                isLoading = false
                areTimersRunning = false
                vm.navigateToFailedView()
            }
        }
    }

    func stopTimers() {
        areTimersRunning = false
    }

    func paymentCheckApiCall() {
        vm.paymentCheck(trxId: HomeDataHandler.shared.beneficiaryCollectionResponse?.transactionNumber ?? "")
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
            
            HStack(spacing:6){
                TextMediumRegular(text: vm.ConfirmationResponse?.readableCode ?? "", fg_color: .textMute)
                    .padding(10)
                    .background(.frForground)
                
                Image("copy")
                    .imageDefaultStyle()
                    .frame(width: 15, height: 15)
                    .padding(.trailing,10)
                    .background(Color.frForground)
                    .cornerRadius(100)
            }
            
            .background(Color.frForground)
            .cornerRadius(18)
           
            
            .onTapGesture {
                UIPasteboard.general.string = vm.ConfirmationResponse?.readableCode
                showToast(message: "Text Copied")
            }
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
