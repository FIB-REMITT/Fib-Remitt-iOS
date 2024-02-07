//
//  FRTextField.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct FRTextField: View {
    var placeholder: AnyView
    @Binding var text: String
    @FocusState var isEditing
    var maxCharacterCount = 100
    
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
        var body: some View {
            ZStack(alignment: .leading) {
                if text.isEmpty { placeholder.foregroundColor(.text_fade) }
                TextField("", text: $text, onEditingChanged: editingChanged, onCommit: commit)
                    .autocapitalization(.none)
                    .autocorrectionDisabled()
                    .foregroundColor(.text_Regula)
                    .onTapGesture { isEditing = true }
                    .focused($isEditing)
                    .onChange(of: text) { newValue in
                        // Check if the length exceeds maxLength
                        if newValue.count > maxCharacterCount {
                            // Truncate the text if it exceeds maxLength
                            text = String(newValue.prefix(maxCharacterCount))
                        }
                    }
                    
        }
    }
}


struct FRSecureField: View {
    var placeholder: Text
    @Binding var text: String
    var editingChanged: (Bool)->() = { _ in }
    var commit: ()->() = { }
        var body: some View {
            ZStack(alignment: .leading) {
                if text.isEmpty { placeholder.foregroundColor(.text_fade) }
                SecureField("", text: $text, onCommit: commit)
                    .foregroundColor(.white)
        }
    }
}
