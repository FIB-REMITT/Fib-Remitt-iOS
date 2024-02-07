//
//  FRVerticalField.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 24/1/24.
//

import SwiftUI

struct FRVerticalField: View {
    var placeholder         : String
    var placeholderIcon     : String?
    @Binding var inputText  : String
    var maxCharacter: Int?
    var extraString: String?
    
    var paddingValue : CGFloat = 15
    var body: some View {
        HStack{
            Text(extraString ?? "").foregroundColor(.textRegula)
            VStack {
                
                FRTextField(placeholder: AnyView(
                    HStack{
                        if let ico = placeholderIcon{ Image(ico)}
                        Text(placeholder)
                    }), text: $inputText,maxCharacterCount: maxCharacter ?? 100)
            }
            .padding(.top,paddingValue)
            .padding(.bottom,paddingValue)
            .padding(.trailing,paddingValue)
            .padding(.leading, extraString?.isBlankOrEmpty ?? true ? paddingValue: 0)
            .background(Color.fr_background)
            .cornerRadius(100)
        }
        .padding(.leading, extraString?.isBlankOrEmpty ?? true ? 0: 20)
        .background(Color.fr_background)
        .cornerRadius(100)
        
    }
}

struct FRVerticalField_Previews: PreviewProvider {
    @State static var selection = ""
    
    static var previews: some View {
        FRVerticalField(placeholder: "Write something", inputText: $selection)
    }
}
