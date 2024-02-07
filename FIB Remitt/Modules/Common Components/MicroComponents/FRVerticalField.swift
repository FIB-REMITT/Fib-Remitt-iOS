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
    
    var paddingValue : CGFloat = 15
    var body: some View {
        VStack {
            FRTextField(placeholder: AnyView( 
                HStack{
                    if let ico = placeholderIcon{ Image(ico)}
                    Text(placeholder)
                }), text: $inputText,maxCharacterCount: maxCharacter ?? 100)
        }   .padding(paddingValue)
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
