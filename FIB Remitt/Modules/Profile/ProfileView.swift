//
//  ProfileView.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 28/1/24.
//

import SwiftUI

struct ProfileView: View {
    
    var body: some View {
        VStack (spacing: 25){
            navigationBar
            //topAccountCreation
            contextContainer
            Spacer()
            //bottomButton
        }
        .padding()
        .background(Color.frBackground.ignoresSafeArea())
        .navigationBarHidden(true)
        //.navigationDestination(isPresented: $vm.goToNext) {vm.destinationView}
    }
}
//MARK: VIEW PARTS
extension ProfileView{
    
    private var navigationBar : some View {
        FRNavigationBarView(title: "Profile", rightView: AnyView(FRBarButton(icon: "bell_ico", action: {self.notificationBtnPressed()})))
    }
    
    private var contextContainer : some View{
        FRVContainer (backgroundColor:.frForground){
            VStack(alignment: .center, spacing: 12, content: {
                Image("profileImage")
                    .imageDefaultStyle()
                    .frame(width: 80, height: 80)
                
                    VStack(spacing: 12, content: {
                        SimpleHColonModInfoView(title: "First name", info: "John")
                        SimpleHColonModInfoView(title: "Last name", info: "Doe")
                        SimpleHColonModInfoView(title: "IBN", info: "13032A")
                    })
                
                Button(action: {
                    //logoutButton Action
                }, label: {
                    VStack(spacing: 2) {
                        Circle()
                            .frame(width: 42, height: 40)
                            .foregroundColor(Color.logout_red)
                            .overlay(content: {
                                Image("logout")
                                    .imageDefaultStyle()
                                    .frame(width: 20 ,height: 20)
                            })
                        TextBaseMedium(text: "Log out", fg_color: .textMute)
                        
                        
                    }
                })

            })
        }
    }
}


//MARK: CUSTOM ACTIONS
extension ProfileView{
    private func notificationBtnPressed() {
        
    }
}

#Preview {
    ProfileView()
}
