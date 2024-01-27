//
//  SplashView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false

    var body: some View {
        ZStack{
            if isActive{
                InitialView()
//                splashView
            }else{
                splashView
            }
        }.onAppear(){
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    self.isActive = true
                }
            }
        }
    }
}

extension SplashView{
    private var splashView : some View{
        ZStack{
            Image("initial_scene_bg")
                .resizable()
                .ignoresSafeArea(.all)
            
            VStack {
                Spacer()
                Image("Logo")
//                    .renderingMode(.original)
                    .imageDefaultStyle()
                    .frame(width: UIScreen.main.bounds.width * 0.224)
                
                TextMediumRegular(text: "Instant Cash Transfers at Your Fingertips. Effortless, Secure, Anytime, Anywhere.", fg_color: .frBackground)
                    .padding(.horizontal, 50)
                    .padding(8)
                    .multilineTextAlignment(.center)
                
                Image("map")
                    .imageDefaultStyle()
                    .padding(29)
                
                Spacer()
                Spacer()
            }
        }
    }
}

#Preview {
    SplashView()
}
