//
//  SimpleHInfoView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct SimpleHInfoView: View {
    var title:String
    var info:String
    
    var body: some View {
        HStack{
            TextBaseRegular(text: title, fg_color: .textMute)
            Spacer()
            TextBaseMedium(text: info, fg_color: .textMute)
                
        }
    }
}

struct SimpleHColonInfoView: View {
    var title:String
    var info:String
    
    var body: some View {
        HStack(spacing:20){
            TextBaseRegular(text: title, fg_color: .textMute)
                .frame(width: 120, alignment: .leading)
            TextBaseRegular(text: ":", fg_color: .textMute)
            TextBaseRegular(text: info, fg_color: .textMute)
            Spacer()

        }
    }
}

#Preview {
    VStack(spacing:20){
        SimpleHInfoView(title: "Delivery Method", info: "Bank Transfer")
        SimpleHColonInfoView(title: "Bank Name", info: "Ziraat Bank")
        SimpleHColonInfoView(title: "Bank ", info: "Ziraat Bank sdfojsdf;")
    }
}
