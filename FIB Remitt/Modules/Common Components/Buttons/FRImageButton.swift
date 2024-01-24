//
//  FRImageButton.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 24/1/24.
//

import SwiftUI

struct FRImageButton: View {
    var image : String
    var size : CGFloat = 24
    var action : () -> Void = {}
    var body: some View {
        Button {
            action()
        } label: {
            Image(image)
                .imageDefaultStyle()
                .frame(width: size, height: size)
        }

        
    }
}

#Preview {
    FRImageButton(image: "bank_ico")
}
