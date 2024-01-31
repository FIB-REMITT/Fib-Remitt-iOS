//
//  DocPickerView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 30/1/24.
//

import SwiftUI

struct DocPickerView: View {
    var title  = "Please upload contract document"
    var body: some View {
        HStack (spacing:15){
            ZStack (alignment: .bottomTrailing){
                Image("folder_ico")
                    .padding(14)
            }
            VStack(alignment:.leading){
                HStack {
                    TextBaseMedium(text:"Browse", fg_color: .primary500)
                }
                TextBaseRegular(text: title, fg_color: .textMute)
            }
            Spacer()
        }.dottedBorder(color: .primary500, lineWidth: 1, dash: [5,3])
    }
}

#Preview {
    DocPickerView()
}
