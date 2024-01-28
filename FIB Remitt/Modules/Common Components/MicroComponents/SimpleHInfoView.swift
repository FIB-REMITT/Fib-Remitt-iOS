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
    var textColor = Color.text_Mute
    var body: some View {
        HStack{
            TextBaseRegular(text: title, fg_color: textColor)
            Spacer()
            TextBaseMedium(text: info, fg_color: textColor)
            
        }
    }
}

enum TextInfoFontStyle {
    case allRegular
    case allBold
    case titleBold
    case infoBold
}


struct SimpleHModInfoView: View {
    var title:String
    var info:String
    var textColor = Color.text_Mute
    var fontStyle: TextInfoFontStyle = .allRegular
    var body: some View {
        HStack{
                if fontStyle == .allRegular {
                    TextBaseRegular(text: title, fg_color: textColor)
                    Spacer()
                    TextBaseRegular(text: info, fg_color: textColor)
                } else if fontStyle == .titleBold {
                    TextBaseMedium(text: title, fg_color: textColor)
                    Spacer()
                    TextBaseRegular(text: info, fg_color: textColor)
                } else if fontStyle == .infoBold {
                    TextBaseRegular(text: title, fg_color: textColor)
                    Spacer()
                    TextBaseRegular(text: info, fg_color: textColor)
                } else {
                    TextBaseMedium(text: title, fg_color: textColor)
                    Spacer()
                    TextBaseMedium(text: info, fg_color: textColor)
                }
        }
    }
}

struct SimpleHInfoRegularView: View {
    var title:String
    var info:String
    var textColor = Color.text_Mute
    var body: some View {
        HStack{
            TextBaseRegular(text: title, fg_color: textColor)
            Spacer()
            TextBaseRegular(text: info, fg_color: textColor)
            
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
