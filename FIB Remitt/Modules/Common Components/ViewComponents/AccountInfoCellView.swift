//
//  AccountInfoCellView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct AccountInfoCellView: View {
    var selected: Bool = false
    var title = "John Doe"
    var subtitle1 = "A/C No. 124 458 458 856"
    var subtitle2 = "Ziraat Bank"
    var icon = ""
    var type : SelectBeneficiaryType = .BankTransfer

    
    // Define a variable to store the image name
    
    
    var body: some View {
        FRVContainer (backgroundColor: .frForground){
            HStack (spacing:15){
                ZStack (alignment: .bottomTrailing){
                    if type == .BankTransfer{
                        Image("bank_ico")
                        .padding(14)
                        .overlay {
                            RoundedRectangle(cornerRadius: 25)
                            .strokeBorder(Color.frBorder, lineWidth: 1)
                            .frame(width: 50, height: 50)
                        }
                    }else{
                        TextH4Medium(text: String(title.prefix(1)).uppercased(), fg_color: .primary500 )
                            .padding(14)
                            .overlay {
                                RoundedRectangle(cornerRadius: 25)
                                .strokeBorder(Color.frBorder, lineWidth: 1)
                                .frame(width: 50, height: 50)
                                
                            }
                    }
                       
                        
//                    Image("turkey")
//                        .imageDefaultStyle()
//                        .frame(width: 15)
                }
                
                VStack(alignment:.leading){
                    HStack {
                        TextBaseMedium(text: title, fg_color: .textRegula)
                            .multilineTextAlignment(.leading)
                        Image(icon)
                            .imageDefaultStyle()
                            .frame(width: 15)
                    }
                    TextBaseRegular(text: "A/C No: \(subtitle1)", fg_color: .textFade)
                        .multilineTextAlignment(.leading)
                    TextBaseRegular(text: subtitle2, fg_color: .textFade)
                        .multilineTextAlignment(.leading)
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
            AccountInfoCellView(selected: selection)
            Spacer()
        }.background(Color.textMute.ignoresSafeArea())
    }
}

