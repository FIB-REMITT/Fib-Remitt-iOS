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
                    Image("sheet_holder_top_line_ico")
                    content
                        .onTapGesture {}
                }
                .padding()
                .frame(width: UIScreen.main.bounds.width )
                .background(Color.fr_forground)
                .clipShape(TopRoundedShape(radius: 12))
                
                //This Rectangle is using for ignoring safe area
                Rectangle()
                    .frame(width: UIScreen.main.bounds.width , height: 0)
                    .background(Color.fr_forground.edgesIgnoringSafeArea(.bottom))
                
            }.onTapGesture {hideKeyboard()}
        }.background(Color.clear)
         .onTapGesture{ onClickOutside() }
    }
}


#Preview {
    SheetHolder {}
}

