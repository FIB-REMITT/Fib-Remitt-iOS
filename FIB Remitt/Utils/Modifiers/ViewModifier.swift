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


struct DottedBorderModifier: ViewModifier {
    var color: Color = .black
    var lineWidth: CGFloat = 1
    var dash: [CGFloat] = [5, 3]

    func body(content: Content) -> some View {
        content
            .overlay(
                RoundedRectangle(cornerRadius: 5)
                    .strokeBorder(style: StrokeStyle(lineWidth: lineWidth, lineCap: .round, dash: dash))
                    .foregroundColor(color)
            )
    }
}

extension View {
    func dottedBorder(color: Color = .black, lineWidth: CGFloat = 1, dash: [CGFloat] = [5, 3]) -> some View {
        self.modifier(DottedBorderModifier(color: color, lineWidth: lineWidth, dash: dash))
    }
}
