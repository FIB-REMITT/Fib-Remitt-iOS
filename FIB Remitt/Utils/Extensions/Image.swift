//
//  Image.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 21/1/24.
//

import SwiftUI

extension Image{
    func imageDefaultStyle() -> some View{
        self
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
    
    func imageFillStyle() -> some View{
        self
        .resizable()
        .aspectRatio(contentMode: .fill)
    }
    
    func topIconStyle() -> some View{
        self
        .imageDefaultStyle()
        .frame(width: 60)
    }
    
    func profileImgStyle() -> some View{
        self
        .imageDefaultStyle()
        .clipShape(Circle())
    }
}
