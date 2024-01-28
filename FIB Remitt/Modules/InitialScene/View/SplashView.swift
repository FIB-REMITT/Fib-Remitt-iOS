//
//  SplashView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct SplashView: View {
    @State private var isActive = false
    @State var currentImage: String = "map"
    @State private var rotationAngle: Double = 0
    var body: some View {
        NavigationStack{
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
                withAnimation(Animation.linear(duration: 1.0).repeatForever(autoreverses: false)) {
                    self.rotationAngle = 360
                }
            }
        }
    }
}

extension SplashView{
    private var splashView : some View{
        ZStack(alignment: .bottom){
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
                
                    Image(currentImage)
                        .imageDefaultStyle()
                    .padding(29)
                
                Spacer()
                Spacer()
            }
            Image("loader")
                .imageDefaultStyle()
                .frame(width: 30, height: 30)
                .rotationEffect(.degrees(rotationAngle))
                .padding(.bottom, 70)
            
        }
        .onAppear {
            Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                withAnimation(.easeInOut(duration: 0.5)) {
                    self.toggleImage()
                }
            }
        }
    }
    
    private func toggleImage() {
        currentImage = (currentImage == "map") ? "map2" : "map"
    }
}

#Preview {
    SplashView()
}
