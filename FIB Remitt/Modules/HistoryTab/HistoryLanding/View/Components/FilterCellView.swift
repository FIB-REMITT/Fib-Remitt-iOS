//
//  FilterCellView.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 30/1/24.
//

import SwiftUI

struct FilterCellView: View {
    var title:String
    var isSelected : Bool
    var body: some View {
        FRHContainer (spacing: 7, alignment:.center, backgroundColor: .fr_background){
            VStack(alignment:.leading, spacing: 7){
                TextBaseMedium(text: title)
                    .multilineTextAlignment(.leading)
            }
            Spacer()
            Image("arrow_right_ico")
        }
        .overlay(RoundedRectangle(cornerRadius: 12).stroke(isSelected ? .green : .clear, lineWidth: 1))
        
    }
}

#Preview {
    FilterCellView(title: "Today", isSelected: true)
}
