//
//  AccountInfoCellView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct AccountInfoCellView: View {
    @Binding var selected: Bool
    var body: some View {
        FRVContainer (backgroundColor: .frForground){
            HStack (spacing:15){
                ZStack (alignment: .bottomTrailing){
                    Image("bank_ico")
                        .padding(14)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(Color.frBorder, lineWidth: 1)
                        }
                    Image("turkey")
                        .imageDefaultStyle()
                        .frame(width: 15)
                }
                
                VStack(alignment:.leading){
                    HStack {
                        TextBaseMedium(text:"John Doe", fg_color: .textRegula)
                        Image("beneficiary_ico")
                            .imageDefaultStyle()
                            .frame(width: 15)
                    }
                    TextBaseRegular(text:"A/C No. 124 458 458 856", fg_color: .textFade)
                    TextBaseRegular(text:"Ziraat Bank", fg_color: .textFade)
                }
                Spacer()
                if selected{
                    Image("tick_circle_ico")
                }

            }
        }.overlay {
            if selected{
                RoundedRectangle(cornerRadius: 18)
                    .strokeBorder(Color.primary500, lineWidth: 1.2)
            }
        }
    }
}

struct AccountInfoCellView_Previews: PreviewProvider {
    @State static var selection = false
    
    static var previews: some View {
        VStack{
            Spacer()
            AccountInfoCellView(selected: $selection)
            Spacer()
        }.background(Color.textMute.ignoresSafeArea())
    }
}

