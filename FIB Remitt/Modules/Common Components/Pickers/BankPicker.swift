//
//  BankPicker.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 30/1/24.
//


import SwiftUI

struct BankPicker: View {
    
    @Environment(\.presentationMode) var presentationMode
    @State var searchText: String = ""
    
    var banks : [BankResponse]
    var itemSelect: (BankResponse) -> Void
    
    var body: some View {
        SheetHolder {
            VStack(spacing: 10){
                TextBaseMedium(text: "Select Bank", fg_color: .textMute).padding(.bottom, 10)
                searchBarContainer
                    .padding(.bottom, 10)
                ScrollView {
                    ForEach(searchText.isEmpty ? banks : banks.filter({ $0.name!.localizedCaseInsensitiveContains(searchText)
                    })) { data in
                        
                        FRSimpleDirectedButton(title: data.name ?? "", icon: "") {
                            itemSelect(data)
                            hideSheet()
                        }
                        
                    }
                }
            }
            
        }
    }
}

extension BankPicker{
    
    //MARK: VIEW PARTS
    private var searchBarContainer : some View {
        HStack(spacing: 12){
            XSearchBar(value: $searchText, action: searchInputPressed, showBtn: false, showIcon: true, height: 50 ,cornerRadious: 100).cornerRadius(100)
        }
    }
    
    //MARK: CUSTOM ACTIONS
    private func searchInputPressed() {}
    
    private func cancelBtnPressed() { presentationMode.wrappedValue.dismiss() }
}

struct BankPicker_Previews: PreviewProvider {
    static var previews: some View {
        BankPicker(banks: [BankResponse(name: "Bangladesh"), BankResponse(name:"Pakisthan")], itemSelect: { item in } )
            .background(Color.textFade)
    }
}
