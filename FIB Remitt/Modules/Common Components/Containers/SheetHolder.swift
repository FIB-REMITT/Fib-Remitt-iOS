//
//  SheetHolder.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//


import SwiftUI

struct SheetHolder<Content:View>: View {
    
    var onClickOutside:() -> Void
    let content: Content
    let transparancy: Double
    let spacing : Double
    
    init( transparancy:Double = 0.3, onClickOutSide: @escaping () -> Void = {hideSheet()}, spacing:Double = 25 , @ViewBuilder content: () -> Content) {
        self.content = content()
        self.transparancy = transparancy
        self.spacing = spacing
        self.onClickOutside = onClickOutSide
    }
    
    var body: some View {
        ZStack{
            Color.black.opacity(transparancy).ignoresSafeArea()
            VStack (spacing:0){
                Spacer()
                VStack (spacing:spacing){
                    Rectangle()
                        .foregroundColor(Color.textFade)
                        .frame(width: UIScreen.main.bounds.width * 0.11, height: 4)
                        .cornerRadius(4)
                        .offset(y:-7)
                    content
                        .onTapGesture {}
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width )
                .background(Color.text_Mute)
                .clipShape(TopRoundedShape(radius: 12))
                
                //This Rectangle is using for ignoring safe area
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width , height: 0)
                    .background(Color.text_Mute.edgesIgnoringSafeArea(.bottom))
                
            }.onTapGesture {hideKeyboard()}
        }.background(Color.clear)
         .onTapGesture{ onClickOutside() }
    }
}


#Preview {
    SheetHolder {}
}

