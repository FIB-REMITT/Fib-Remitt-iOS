//
//  FRTextButton.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct FRTextButton: View {
    var title:String
    var color:Color = .primary500
    var action: () -> Void = {}
    var body: some View {
        Button(action: { action()}, label: {
            TextBaseMedium(text: title,fg_color: color).underline()
        })
    }
}

#Preview {
    FRTextButton(title: "+Add New")
}
