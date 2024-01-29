//
//  PurposePicker.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 29/1/24.
//

import SwiftUI

struct PurposePicker: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var searchText: String = ""
    
    var purposes : [PurposeResponse]
    var itemSelect: (PurposeResponse) -> Void
    
    var body: some View {
        SheetHolder {
            VStack(spacing: 10){
                TextBaseMedium(text: "Purpose", fg_color: .textMute).padding(.bottom, 10)
                searchBarContainer
                    .padding(.bottom, 10)
                ScrollView {
                    ForEach(searchText.isEmpty ? purposes : purposes.filter({ $0.name!.localizedCaseInsensitiveContains(searchText)
                    })) { data in
                        Button {
                            itemSelect(data)
                            hideSheet()
                        } label: {
                            PurposeCellView(title: data.code ?? "", description: data.name ?? "")
                        }
                    }
                }
            }
            
        }
    }
}

extension PurposePicker{
    
    //MARK: VIEW PARTS
    private var searchBarContainer : some View {
        HStack(spacing: 12){
            XSearchBar(value: $searchText, action: searchInputPressed, showBtn: false, showIcon: true, height: 50 ,cornerRadious: 100).cornerRadius(100)
//            XBtnWithText(textColor: .btn_primary, textBtnTitle: "Cancel", action: cancelBtnPressed)
        }
    }
    
    //MARK: CUSTOM ACTIONS
    private func searchInputPressed() {}
    
    private func cancelBtnPressed() { presentationMode.wrappedValue.dismiss() }
}

struct SellCryptoPickerView_Previews: PreviewProvider {
    static var previews: some View {
        PurposePicker(purposes: [PurposeResponse(name: "Family Support"),PurposeResponse(name: "Account Opening")], itemSelect: { CurrencyTypesItems in } )
            .background(Color.textFade)
    }
}
