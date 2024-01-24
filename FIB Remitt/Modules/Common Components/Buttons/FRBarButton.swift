//
//  FRBarButton.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 23/1/24.
//

import SwiftUI

struct FRBarButton: View {
    @Environment(\.presentationMode) var presentationMode
    var icon    : String
    var action  : (() -> Void)? = nil
    var body: some View {
        Button(action: {
            if let action{action()}else{presentationMode.wrappedValue.dismiss()}
        }, label: {
            Image(icon)
                .imageDefaultStyle()
                .frame(width: 26 ,height: 26)
                .padding(4)
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
