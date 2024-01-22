//
//  SimpleHInfoCellView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct SimpleHInfoCellView: View {
    var title : String = "Delivery Method"
    var info  : String = "Bank Transfer"
    var body: some View {
        FRVContainer(backgroundColor:.frForground){
            SimpleHInfoView(title : title, info : info)
        }
    }
}

#Preview {
    ZStack{
        Color.frBackground.ignoresSafeArea()
        SimpleHInfoCellView()
    }
}
