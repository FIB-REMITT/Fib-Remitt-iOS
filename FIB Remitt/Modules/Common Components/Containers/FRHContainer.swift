//
//  FRHContainer.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 24/1/24.
//

import SwiftUI

struct FRHContainer<Content:View>: View {
    
    let content: Content
    let spacing : Double
    let alignment: VerticalAlignment
    let backgroundColor: Color
    
    init(spacing:Double = 25 , alignment:VerticalAlignment = .center, backgroundColor:Color = .textFade, @ViewBuilder content: () -> Content) {
        self.content         = content()
        self.spacing         = spacing
        self.alignment       = alignment
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
            VStack (spacing:0){
                HStack (alignment:alignment, spacing:spacing){
                    content
                        .onTapGesture {}
                }
                .padding()
                .frame(maxWidth: .infinity )
                .background(backgroundColor)
                .cornerRadius(18)
                .shadow(color: .textFade, radius: 0.15)
            }
    }
}
