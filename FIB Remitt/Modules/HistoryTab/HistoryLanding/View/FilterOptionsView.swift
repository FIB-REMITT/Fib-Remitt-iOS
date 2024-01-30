//
//  FilterOptionsView.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 30/1/24.
//

import SwiftUI

struct FilterOptionsView: View {
    @Environment(\.presentationMode) var presentationMode
    let options: [String] = ["All", "Today", "Last 7 Days", "This Month", "This Year"]
    @State var selectedValue : String
    
    var onSelected: (String) -> Void
    var body: some View {
        SheetHolder {
            VStack(spacing: 8){
                ForEach(options, id: \.self) { option in
                    FilterCellView(title: option, isSelected: option == selectedValue)
                        .onTapGesture {
                            selectedValue = option
                            onSelected(option)
                            closeTheFilterBottomSheet()
                        }
                }
            }
        }
    }
}
extension FilterOptionsView{
    private func closeTheFilterBottomSheet(){
        presentationMode.wrappedValue.dismiss()
    }
}
//#Preview {
//    FilterOptionsView(selectedValue: "All", onSelected: <#(String) -> Void#>)
//}
