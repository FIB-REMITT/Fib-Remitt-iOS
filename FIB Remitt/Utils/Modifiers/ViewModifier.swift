//
//  ViewModifier.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 21/1/24.
//

import SwiftUI

struct XVerticalShapeStyle : ViewModifier{
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .frame(height: 50)
            .frame(maxWidth: .infinity)
            .buttonStyle(.plain)
    }
}
