//
//  SimpleDirectedView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct SimpleDirectedCellView: View {
    var title : String = "FIB Personal App"
    var backgroundColor:Color = .fr_forground
    var body: some View {
        FRVContainer(backgroundColor: backgroundColor) {
            HStack{
                TextBaseMedium(text: title)
                Spacer()
                Image("arrow_right_ico")
            }
        }
    }
}

#Preview {
    ZStack{
        Color.fr_background.ignoresSafeArea()
        SimpleDirectedCellView()
    }

}
