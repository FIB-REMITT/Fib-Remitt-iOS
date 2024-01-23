//
//  FRBarButton.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct FRBarButton: View {
    var icon    : String
    var action  : () -> Void = {}
    var body: some View {
        Button(action: { action() }, label: {
            Image(icon)
                .imageDefaultStyle()
                .frame(width: 20 ,height: 20)
                .padding(6)
                .background(.frForground)
                .cornerRadius(5)
        })

    }
}

#Preview {
    ZStack{
        Color.frBackground.ignoresSafeArea()
        FRBarButton(icon: "back_arrow")
    }
}
