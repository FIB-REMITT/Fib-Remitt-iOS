//
//  InitialView.swift
//  FIBInit
//
//  Created by Ainul Kazi on 21/1/24.
//

import SwiftUI

struct InitialView: View {
    var body: some View {
        ZStack {
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
                FRVerticalBtn(title: "Log In With FIB", textColor:.primary500) {}
                    .padding()
                Spacer()
            }

        }
       // .padding()
    }
}

#Preview {
    InitialView()
}
