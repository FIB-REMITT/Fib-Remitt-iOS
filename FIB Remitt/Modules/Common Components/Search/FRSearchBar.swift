//
//  FRSearchBar.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 29/1/24.
//

import SwiftUI

struct XSearchBar: View {
    var placeHolder : String = "Search here"
    @Binding var value : String
    var action : ()->Void
    var showBtn : Bool = true
    var showIcon : Bool = false
    var height : CGFloat = 50
    var cornerRadious : CGFloat = 100
    @FocusState var isEditing :Bool
    
    var body: some View {
        HStack(spacing: 8){
            HStack(spacing: 0){
                if showIcon == true{
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.textMute)
                }
                XTitledSearchField(placeholder: placeHolder, value: $value, isEditing: _isEditing, height: height)
                
                if isEditing{
                    Button {isEditing = false; value = "" } label: {
                        Image(systemName: "xmark")
                        .imageDefaultStyle()
                        .frame(width: 18)
                        .foregroundColor(.white)
                        .padding(5)
                        .background(Color.black)
                        .cornerRadius(5) }
                }
            }
            .searchbarStyle()
            
            if showBtn == true{
                FRVerticalBtn(action: action, icon: "magnifyingglass")
                    .cornerRadius(cornerRadious)
                    .frame(maxWidth: 48)
            }
        }.overlay{
            isEditing ? RoundedRectangle(cornerRadius:100)
                .stroke(Color.primary_300, lineWidth: 2) : nil
        }
    }
}
