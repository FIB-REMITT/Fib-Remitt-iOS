//
//  BeneficiaryDetailView.swift
//  FIB Remitt
//
//  Created by Izak on 23/1/24.
//

import SwiftUI

struct BeneficiaryDetailView: View {
    var body: some View {
        VStack{
            FRVContainer (backgroundColor:.frForground){
                HStack{
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
                }
            }
        }
        .padding()
        .background(Color.fr_background.ignoresSafeArea())
    }
}

#Preview {
    BeneficiaryDetailView()
}
