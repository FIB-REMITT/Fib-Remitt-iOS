//
//  HomePayViaFIBView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct HomePayViaFIBView: View {
    var body: some View {
        VStack{
            TextBaseRegular(text: "Scan bellow QR using FIB App", fg_color: .textMute)
            Image("QR_Img")
            TextMediumRegular(text: "EFGH-ABCD-IJKL-MNOP", fg_color: .textMute)
                .padding()
                .background(.frForground)
                .cornerRadius(18)
                

            TextBaseRegular(text: "Already have FIB on your phone?", fg_color: .textMute).padding(.vertical)
            SimpleDirectedCellView()
            SimpleDirectedCellView()
            SimpleDirectedCellView()
            Spacer()
            Button(action: {
                
            }, label: {
                TextBaseRegular(text: "Cancel", fg_color: .red).underline()
            })

        }
        .padding()
        .background(Color.frBackground.ignoresSafeArea())
    }
}

#Preview {
    HomePayViaFIBView()
}
