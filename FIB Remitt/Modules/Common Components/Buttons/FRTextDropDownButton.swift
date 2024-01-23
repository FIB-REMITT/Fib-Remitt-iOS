//
//  FRTextDropDownButton.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct FRTextDropDownButton: View {
    var title : String
    var action : () -> Void = {}
    var body: some View {
        Button(action: {action()}, label: {
            HStack{
                TextBaseMedium(text: title)
                Image(systemName: "chevron.down").foregroundColor(.text_Regula)
            }
        })
    }
}

#Preview {
    FRTextDropDownButton(title: "Today")
}
