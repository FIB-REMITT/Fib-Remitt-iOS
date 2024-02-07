//
//  AccountInfoCellViewButton.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 30/1/24.
//

import SwiftUI

struct AccountInfoCellViewButton: View {
    var selected: Bool = false
    var title = "John Doe"
    var subtitle1 = "IBAN. 124 458 458 856"
    var subtitle2 = "Ziraat Bank"
    var icon = ""
    var action : ()->Void = {}
    
    var body: some View {
        Button {
            action()
        } label: {
            AccountInfoCellView(selected: selected, title: title, subtitle1: subtitle1, subtitle2: subtitle2, icon: icon)
        }

    }
}

#Preview {
    AccountInfoCellViewButton()
}
