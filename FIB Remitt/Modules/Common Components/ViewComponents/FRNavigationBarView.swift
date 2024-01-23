//
//  FRNavigationBarView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct FRNavigationBarView: View {
    var leftView  : AnyView = AnyView(FRBarButton(icon: "back_arrow"))
    var title     : String = ""
    var rightView : AnyView?
    
    var body: some View {
        HStack{
            leftView
            Spacer()
            TextBaseMedium(text: title)
            Spacer()
            if let rView = rightView{
             rView
            }
        }
    }
}

#Preview {
    ZStack{
        Color.frBackground.ignoresSafeArea()
        FRNavigationBarView(title: "Transfer History")
    }
}
