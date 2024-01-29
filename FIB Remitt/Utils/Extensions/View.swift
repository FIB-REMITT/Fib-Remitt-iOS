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
    
    func tabItemStyle(isSelected:Bool) -> some View {
        self.foregroundColor(isSelected ? Color.white : .textFade)
            .padding(.vertical, 8)
            .frame(maxWidth: .infinity)
            .cornerRadius(6)
    }
    

    func searchbarStyle() -> some View {
        self
        //.frame(height:50)
            .padding(.horizontal, 10)
            .background(Color.fr_background)
            .cornerRadius(7)
            .foregroundColor(.textMute)
        
    }

}
