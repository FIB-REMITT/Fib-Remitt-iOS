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
            Spacer()
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
