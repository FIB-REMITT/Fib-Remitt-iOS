//
//  FRText.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 21/1/24.
//

import SwiftUI

struct TextBaseRegular: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .baseRegular, forgroundColor: fg_color)
    }
}

struct TextBaseMedium: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .baseMedium, forgroundColor: fg_color)
    }
}

struct TextBaseBold: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .baseBold, forgroundColor: fg_color)
    }
}

struct TextMediumRegular: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .mediumRegular, forgroundColor: fg_color)
    }
}

struct TextMediumMedium: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .mediumMedium, forgroundColor: fg_color)
    }
}

struct TextMediumBold: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .mediumBold, forgroundColor: fg_color)
    }
}

struct TextSmallRegular: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .smallRegular, forgroundColor: fg_color)
    }
}

struct TextSmallMedium: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .smallMedium, forgroundColor: fg_color)
    }
}

struct TextSmallBold: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .smallBold, forgroundColor: fg_color)
    }
}

struct TextH6Regular: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .H6Regular, forgroundColor: fg_color)
    }
}

struct TextH6Medium: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .H6Medium, forgroundColor: fg_color)
    }
}

struct TextH6Bold: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .H6Bold, forgroundColor: fg_color)
    }
}

struct TextH5Regular: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .H5Regular, forgroundColor: fg_color)
    }
}

struct TextH5Medium: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .H5Medium, forgroundColor: fg_color)
    }
}

struct TextH5Bold: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .H5Bold, forgroundColor: fg_color)
    }
}



struct TextH4Regular: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .H4Regular, forgroundColor: fg_color)
    }
}

struct TextH4Medium: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .H4Medium, forgroundColor: fg_color)
    }
}

struct TextH4Bold: View {
    var text:String
    var fg_color:Color = .text_Regula
    var body: some View {
        DRText(text: text, drFontStyle: .H4Bold, forgroundColor: fg_color)
    }
}

struct DRText: View {
    var text:String
    var drFontStyle:DesignedFontStyle
    var forgroundColor:Color = .text_Regula
    
    var body: some View {
        Text(text)
            .font(UI.FRAppDesignedFont(style: drFontStyle))
            .foregroundColor(forgroundColor)
    }
}
