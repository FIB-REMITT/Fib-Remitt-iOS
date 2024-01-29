//
//  FRContainer.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct FRVContainer<Content:View>: View {
    
    let content: Content
    let spacing : Double
    let alignment: HorizontalAlignment
    let backgroundColor: Color
    
    init(spacing:Double = 25 , alignment:HorizontalAlignment = .leading, backgroundColor:Color = .textFade, @ViewBuilder content: () -> Content) {
        self.content         = content()
        self.spacing         = spacing
        self.alignment       = alignment
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
            VStack (spacing:0){
                VStack (alignment:alignment, spacing:spacing){
                    content
//                        .onTapGesture {}
                }
                .padding()
                .frame(maxWidth: .infinity )
                .background(backgroundColor)
                .cornerRadius(18)
                .shadow(color: .textFade, radius: 0.15)
            }
    }
}


#Preview {
    FRVContainer(spacing:10, alignment: .trailing, backgroundColor: .primary200) {
        TextMediumRegular(text: "Instant Cash Transfers at Your Fingertips. Effortless, Secure, Anytime, Anywhere.", fg_color: .textFade)
            .padding(.horizontal, 0)
            .multilineTextAlignment(.center)
        
        TextMediumRegular(text: "Instant Cash Transfers at Your", fg_color: .frBackground)
            .padding(.horizontal, 10)
            .padding(8)
            .multilineTextAlignment(.center)
        
        Image("map")
            .imageDefaultStyle()
            .padding(29)
    }
}

