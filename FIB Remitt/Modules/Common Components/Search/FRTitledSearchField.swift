//
//  FRTitledSearchField.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 29/1/24.
//
import SwiftUI

struct XTitledSearchField : View{
    var placeholder : String
    @Binding var value : String
    @FocusState var isEditing : Bool
    var title : String?
    var height: CGFloat = 50
    
    func customTextField() -> some View {
        FRTextField(placeholder: Text(placeholder), text: $value, isEditing: _isEditing)
            .frame(height:height)
            .searchbarStyle()
    }
    
    var body: some View{
        if let title = self.title{
            VStack (spacing: 5){
                Text(title)
                   // .fieldTitleStyle()
                customTextField()
            }

        }else{
            customTextField()
        }
        
    }
}
