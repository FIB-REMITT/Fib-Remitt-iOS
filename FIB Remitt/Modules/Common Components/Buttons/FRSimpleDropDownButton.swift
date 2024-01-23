//
//  FRSimpleDropDownButtonView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct FRSimpleDropDownButton: View {
    var title  : String = "Family Support"
    var icon   : String?
    var bg_color: Color = .fr_background
    var isContextMedium : Bool = false
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
                    Image(systemName: "chevron.down")
                }
                .foregroundColor(.text_Mute)
                
            }
        })

    }
}

#Preview {
    FRSimpleDropDownButton()
}
