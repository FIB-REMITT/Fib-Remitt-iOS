//
//  FIBLoaderView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 25/1/24.
//


import SwiftUI

struct FIBLoaderView: View {
    @State private var isAnimating: Bool = false
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.8).ignoresSafeArea()
                .ignoresSafeArea()
            VStack (spacing: 20){
                ZStack {
                    
                    TextH4Bold(text: "FIB", fg_color: .primary500)
                    
                    Circle()
                        .trim(from: 0, to: 0.8)
                        .stroke(AngularGradient(gradient: .init(colors: [.primary500, .white]), center: .center), style: StrokeStyle(lineWidth: 10, lineCap: .round))
                        .frame(width: 80, height: 80)
                        .rotationEffect(.degrees(isAnimating ? 360 : 0))
                        .animation(isAnimating ? Animation.linear(duration: 0.9).repeatForever(autoreverses: false) : nil, value: isAnimating)
                        .onAppear {
                            self.isAnimating = true
                        }
                }
            }
        }
        
    }
}



#Preview {
    FIBLoaderView()
}
