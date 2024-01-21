//
//  View.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 21/1/24.
//

import SwiftUI

extension View{
    func frVerticalShapeStyle() -> some View {
        ModifiedContent(
            content: self,
            modifier: XVerticalShapeStyle()
        )
    }
    
    func verticalBtnStyle() -> some View {
        self
            .frVerticalShapeStyle()
            .font(UI.FRAppDesignedFont(style: .baseMedium))
            .cornerRadius(15)
    }
}
