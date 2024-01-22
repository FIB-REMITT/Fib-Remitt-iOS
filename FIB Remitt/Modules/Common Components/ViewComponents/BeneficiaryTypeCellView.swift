//
//  BeneficiaryTypeCellView.swift
//  FIB Remitt
//
//  Created by Izak on 23/1/24.
//

import SwiftUI

struct BeneficiaryTypeCellView: View {
    @Binding var selected: Bool
    var title : String
    var icon : String?
    var body: some View {
        HStack(alignment:.center){
            if let icn = icon{
                Image(icn)
                    .imageDefaultStyle()
                    .frame(width: 20)
            }
            TextBaseMedium(text: title, fg_color: .textFade)
        }
        .padding(10)
        .padding(.horizontal, 10)
        .background(selected ? Color.primary_50 : Color.fr_forground)
        .cornerRadius(15)
        .shadow(radius: 0.2)
        .overlay {
            if selected{
                RoundedRectangle(cornerRadius: 15)
                .strokeBorder(Color.primary500, lineWidth: 1)
            }
        }
    }
}

struct BeneficiaryTypeCellView_Previews: PreviewProvider {
    @State static var selection = false
    
    static var previews: some View {
        ZStack{
            Color.fr_background.ignoresSafeArea()
            BeneficiaryTypeCellView(selected: $selection, title: "All", icon: "bank_ico")
        }
    }
}
