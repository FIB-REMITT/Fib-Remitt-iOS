//
//  FilePickerCellView.swift
//  FIB Remitt
//
//  Created by Raihan on 29/1/24.
//

import Foundation
import SwiftUI

struct FilePickerCellView: View {
    @Binding var selected: Bool
    var body: some View {
        ZStack{
            VStack(alignment:.leading){
                TextBaseMedium(text: "Proceed", fg_color: .textFade)
                HStack (spacing:15){
                    ZStack (alignment: .bottomTrailing){
                        Image("folder_ico")
                            .padding(14)
                    }
                    VStack(alignment:.leading){
                        HStack {
                            TextBaseMedium(text:"Browse", fg_color: .primary500)
                        }
                        TextBaseRegular(text:"Please upload contract document", fg_color: .textMute)
                    }
                    Spacer()
                }.dottedBorder(color: .primary500, lineWidth: 1, dash: [5,3])
                
            }
            .padding(20)
            .contentShape(Rectangle())
        }.background(Color.white)
            .cornerRadius(10)
            .frame(width: 300, height: 200)
            .shadow(radius: 10)
        
        
    }
}

struct FilePickerCellView_Previews: PreviewProvider {
    @State static var selection = false
    
    static var previews: some View {
        VStack{
            Spacer()
            FilePickerCellView(selected: $selection)
            Spacer()
        }.background(Color.textMute.ignoresSafeArea())
    }
}



