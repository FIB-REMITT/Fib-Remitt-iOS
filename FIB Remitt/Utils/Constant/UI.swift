//
//  UI.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 21/1/24.
//

import SwiftUI

struct UI {
    private init(){}
    
    static let FR_THEME : ColorScheme = .Common
    static let designScreenHeight : CGFloat = 812*0.75
    static let pt : CGFloat = 0.75
    
    static func FRAppFont(ofSize size: CGFloat, style: FontStyle) -> Font{
        let calculatedSize = ((size*pt) * UIScreen.main.bounds.height)/designScreenHeight
        switch style {
        case .regular :
            return .custom("Roboto", size: calculatedSize)
        case .thin :
            return .custom("Roboto-Thin", size: calculatedSize)
        case .extraLight :
            return .custom("Roboto-ExtraLight", size: calculatedSize)
        case .light :
            return .custom("Roboto-Light", size: calculatedSize)
        case .medium :
            return .custom("Roboto-Medium", size: calculatedSize)
        case .semiBold :
            return .custom("Roboto-SemiBold", size: calculatedSize)
        case .bold :
            return .custom("Roboto-Bold", size: calculatedSize)
        case .extraBold :
            return .custom("Roboto-ExtraBold", size: calculatedSize)
        case .black :
            return .custom("Roboto-Black", size: calculatedSize)
            
        }
    }
    
    
    static func FRAppDesignedFont(style: DesignedFontStyle) ->  Font{
        
        let scHeight = UIScreen.main.bounds.height
        switch style {
        case .baseRegular :
            return Font.custom( "Roboto-Regular", size: ((14*pt)*scHeight)/designScreenHeight)  // ?? Font.system(size: 14)
        case .baseMedium :
            return Font.custom( "Roboto-Medium", size: ((14*pt)*scHeight)/designScreenHeight)  // ?? Font.system(size: 14)
        case .baseBold :
            return Font.custom( "Roboto-Bold", size: ((14*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 14)
        case .mediumRegular :
            return Font.custom( "Roboto-Regular", size: ((12*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 16)
        case .mediumMedium :
            return Font.custom( "Roboto-Medium", size: ((12*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 12)
        case .mediumBold :
            return Font.custom( "Roboto-Bold", size: ((12*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 12)
        case .smallRegular :
            return Font.custom( "Roboto-Regular", size: ((10*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 12)
        case .smallMedium :
            return Font.custom( "Roboto-Medium", size: ((10*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 12)
        case .smallBold:
            return Font.custom( "Roboto-Bold", size: ((10*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 10)
        case .H6Regular:
            return Font.custom( "Roboto-Regular", size: ((18*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 10)
        case .H6Medium:
            return Font.custom( "Roboto-Medium", size: ((18*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 10)
        case .H6Bold:
            return Font.custom( "Roboto-Bold", size: ((18*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 10)
        case .H5Regular:
            return Font.custom( "Roboto-Regular", size: ((22*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 10)
        case .H5Medium:
            return Font.custom( "Roboto-Medium", size: ((22*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 10)
        case .H5Bold:
            return Font.custom( "Roboto-Bold", size: ((22*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 10)
        case .H4Regular:
            return Font.custom( "Roboto-Regular", size: ((24*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 10)
        case .H4Medium:
            return Font.custom( "Roboto-Medium", size: ((24*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 10)
        case .H4Bold:
            return Font.custom( "Roboto-Bold", size: ((24*pt)*scHeight)/designScreenHeight) //  ?? Font.system(size: 10)
            
        }
        
    }
    
    struct FontWithLineHeight: ViewModifier {
        let font: UIFont
        let lineHeight: CGFloat
        
        func body(content: Content) -> some View {
            content
                .font(Font(font))
                .lineSpacing(lineHeight - font.lineHeight)
                .padding(.vertical, (lineHeight - font.lineHeight) / 2)
        }
    }
    
    public enum ColorScheme : CaseIterable {
        case LightMode
        case DarkMode
        case Common
    }
    
    static func AppThemeColor(name:String)-> Color{
        switch UI.FR_THEME{
        case .Common:
            return Color(name)
        case .DarkMode:
            return Color("\(name)_dark")
        case .LightMode:
            return Color("\(name)_light")
            
        }
    }
}

public enum FontStyle {
    case regular
    case thin
    case extraLight
    case light
    case medium
    case semiBold
    case bold
    case extraBold
    case black
}

public enum DesignedFontStyle {
    case baseRegular
    case baseMedium
    case baseBold
    case mediumRegular
    case mediumMedium
    case mediumBold
    case smallRegular
    case smallMedium
    case smallBold
    case H6Regular
    case H6Medium
    case H6Bold
    case H5Regular
    case H5Medium
    case H5Bold
    case H4Regular
    case H4Medium
    case H4Bold
}
