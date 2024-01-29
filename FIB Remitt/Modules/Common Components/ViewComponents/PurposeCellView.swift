//
//  PurposeCellView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 29/1/24.
//

import SwiftUI

struct PurposeCellView: View {
    var title:String
    var description:String
    var body: some View {
        FRHContainer (spacing: 7, alignment:.center, backgroundColor: .fr_background){
            VStack(alignment:.leading, spacing: 7){
                TextBaseMedium(text: title)
                TextMediumRegular(text: description, fg_color: .textFade)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            Image("arrow_right_ico")
        }
    }
}

#Preview {
    PurposeCellView(title: "Family Support", description:  "Money sent to family members for general living expenses and support.")
}
