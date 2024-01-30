//
//  FRVerticalButton.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 21/1/24.
//

import SwiftUI

struct FRVerticalBtn: View {

    var title       : String?
    var btnColor    : Color = .white
    var textColor   : Color = Color.white
    var action      : ()->Void
    var icon        : String?
    
    var body : some View {
        Button(action: action, label: {
            HStack(spacing: 12){
                if icon != nil {
                    Image(systemName: icon ?? "")
                        .imageDefaultStyle()
                        .frame(maxWidth: 15, maxHeight: 17)
                        .foregroundColor(.white)
                }
                
                if title != nil { TextBaseMedium(text: title ?? "", fg_color: textColor) }
            }
            .frVerticalShapeStyle()
            .background(btnColor)
            .cornerRadius(25)

        })
    }
}

struct FRVerticalControlBtn: View {
    
    @Binding var isDisabled:Bool
    
    var title: String
    var action : ()->Void
    var icon : String?
    var body: some View {
        Button(action: action, label: {
            HStack(spacing: 12){
                if icon != nil {
                    Image(systemName: icon ?? "")
                        .imageDefaultStyle()
                        .frame(maxWidth: 15, maxHeight: 17)
                        .foregroundColor(.white)
                }
                FRTextButton(title: title,color: !isDisabled ? Color.white : Color.white)
            }
            .frVerticalShapeStyle()
            .background(!isDisabled ? Color.textMute.opacity(0.2) : Color.primary500)
            .cornerRadius(25)
            
        }).disabled(!isDisabled)
    }
}
