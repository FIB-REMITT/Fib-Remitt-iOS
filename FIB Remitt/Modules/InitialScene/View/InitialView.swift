//
//  InitialView.swift
//  FIBInit
//
//  Created by Ainul Kazi on 21/1/24.
//

import SwiftUI

struct InitialView: View {
    @ObservedObject var vm = AuthViewModel()
   // @StateObject var viewModel = AuthViewModel()
    @State var tapped      = false

    var body: some View {
        NavigationStack{
            ZStack {
                if tapped{
                    FRBottomBarContainer()
                }else{
                    backgroundView
                    VStack {
                        Spacer()
                        topLogo
                        middaleDescription
                        middaleBgMap
                        Spacer()
                        bottomLoginButton
                        bottomDownloadOptionContainer
                        Spacer()
                    }
                }
            }.navigationBarHidden(true)
            .navigationDestination(isPresented: $vm.goToNext, destination: {vm.destinationView})
//            .onChange(of: vm.loggedIn, perform: { value in
//                self.tapped = value
//            })
        }
    }
}

//MARK: - VIEWCOMPONENTS
extension InitialView {
    private var backgroundView : some View{
        Image("initial_scene_bg")
            .resizable()
            .ignoresSafeArea(.all)
    }
    
    private var topLogo : some View{
        Image("Logo")
        //                    .renderingMode(.original)
            .imageDefaultStyle()
            .frame(width: UIScreen.main.bounds.width * 0.224)
    }
    
    private var middaleDescription : some View{
        TextMediumRegular(text: "Instant Cash Transfers at Your Fingertips. Effortless, Secure, Anytime, Anywhere.", fg_color: .frBackground)
            .padding(.horizontal, 50)
            .padding(8)
            .multilineTextAlignment(.center)
    }
    
    private var middaleBgMap: some View{
        Image("map")
            .imageDefaultStyle()
            .padding(29)
    }
    
    private var bottomLoginButton : some View{
        FRVerticalBtn(title: "Log In With FIB", textColor:.primary500) {self.loginWithFIBButtonPressed()}
            .padding()
    }
    private var bottomDownloadOptionContainer : some View{
        HStack{
            TextMediumRegular(text: "Don’t have FIB App?", fg_color: .fr_forground)
            FRTextButton(title: "Download Now", color: .fr_forground, action: {self.downloadNowButtonPressed()})
        }
    }
    
}

//MARK: - ACTIONS
extension InitialView {
    private func loginWithFIBButtonPressed() {
//        vm.navigateToHome()
        self.tapped = true
        vm.login() 

    }
    private func downloadNowButtonPressed(){}
}

#Preview {
    InitialView()
}
