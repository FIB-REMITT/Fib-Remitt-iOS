//
//  FRSimpleDirectedButton.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 30/1/24.
//

import SwiftUI

struct FRSimpleDirectedButton: View {
    var title  : String = "Turkey"
    var icon   : String?
    var bg_color: Color = .fr_background
    var isContextMedium : Bool = false
    var cornerRadius : CGFloat = 100.0
    var action : () -> Void = {}
    var body: some View {
        
        Button(action: {
            action()
        }, label: {
            FRVContainer (backgroundColor: bg_color){
                HStack{
                    if let icn = icon{
                        Image(icn)
                            .imageDefaultStyle()
                            .frame(width: 24)
                    }
                    if isContextMedium{
                        TextBaseMedium(text:title, fg_color: .text_Mute)
                    }else{
                        TextBaseRegular(text:title, fg_color: .text_Mute)
                    }
                    
                    Spacer()
                    Image("arrow_right_ico")
                }
                .foregroundColor(.text_Mute)
                
            }
            .cornerRadius(cornerRadius)
        })

    }
}

#Preview {
    FRSimpleDirectedButton()
}
