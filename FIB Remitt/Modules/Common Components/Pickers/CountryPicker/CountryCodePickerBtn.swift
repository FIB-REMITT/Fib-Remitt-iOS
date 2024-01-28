//
//  CountryCodePickerBtn.swift
//  IQDX
//
//  Created by Ainul Kazi on 3/8/23.
//

import SwiftUI

struct CountryCodePickerBtn: View {
    @Binding var selectedCountry:CurrencyResponse
    var body: some View {
        Button {
            let vc = UIHostingController(rootView: PickerView(selected: $selectedCountry))
            getWindow().rootViewController?.present(vc, animated: true)
        } label: {
            HStack {
                TextBaseMedium(text: selectedCountry.flag)
                TextBaseBold(text: "(\(selectedCountry.countryCode))")
                Image("arrow_down_ico").frame(width: 10 , height: 20)
            }
            .padding(8)
            .font(.system(size: 13))
            .foregroundColor(.white)
            .frame(height: 48)
            .background(Color.fr_background)
            .cornerRadius(100)
        }
    }
}

struct CountryCodePickerBtn_Previews: PreviewProvider {
    @State static var selectedCountry:CurrencyResponse = CurrencyResponse(countryName: "Iraq", countryCode: "+964", flag: "🇮🇶")
    static var previews: some View {
        CountryCodePickerBtn(selectedCountry: $selectedCountry)
    }
}
