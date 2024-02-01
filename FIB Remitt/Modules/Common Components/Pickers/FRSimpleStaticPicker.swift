//
//  FRSimpleStaticPicker.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 29/1/24.
//

import SwiftUI

struct FRSimpleStaticPicker<T: RawRepresentable & CaseIterable & Hashable>: View where T.RawValue == String {
    let type: T.Type
    @Binding var selected: T
    
    var body: some View {
        SheetHolder (spacing: 12){
            ForEach(Array(T.allCases), id: \.self) { item in
                FRSimpleDirectedCellButton(title: item.rawValue, backgrounColor: .fr_background, action: {
                    self.selected = item
                    getWindow().rootViewController?.dismiss(animated: true, completion: nil)
                })
            }
        }
    }
}
