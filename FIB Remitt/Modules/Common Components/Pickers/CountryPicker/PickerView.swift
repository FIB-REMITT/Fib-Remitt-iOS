//
//  PickerView.swift
//  SwiftUITest1
//
//  Created by Ainul on 19/3/23.
//

import SwiftUI

struct PickerView: View {
    
    @State var searchText = ""
    @Binding var selected:CountryPickerItem
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, placeholder: "Search items")
            ScrollView {
                ForEach(filteredItems(), id: \.self) { item in
                    createCountryRow(country: item)
                }
            }
        }.padding()
    }
    
    func filteredItems() -> [CountryPickerItem]{
        if searchText.isEmpty {
            return CountryPickerItem.data
        } else {
            return CountryPickerItem.data.filter { $0.countryName.localizedCaseInsensitiveContains(searchText) }
        }
    }
}


extension PickerView{
    func createCountryRow(country:CountryPickerItem) -> some View {
        HStack (spacing:6){
            Text(country.flag)
            Text(country.countryName)
            Spacer()
            
            Text(country.countryCode)
                .foregroundColor(.gray)
            Image(systemName: "checkmark.circle.fill")
                .foregroundColor(selected == country ? .green : .clear)
                .padding(.horizontal, 5)
        }.padding()
            .onTapGesture {
                selected = country
                hideSheet()
            }
    }
}

struct SearchBar: View {
    @Binding var text: String
    var placeholder: String

    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
            TextField(placeholder, text: $text)
                .textFieldStyle(RoundedBorderTextFieldStyle())
        }
        .padding(.horizontal)
    }
}


struct CountryPickerItem:Hashable {
    
    let countryName : String
    let countryCode : String
    let flag : String
    
    static let data: [CountryPickerItem] = [
        CountryPickerItem(countryName: "Iraq", countryCode: "+964", flag: "🇮🇶"),
        CountryPickerItem(countryName: "Finland", countryCode: "+358", flag: "🇫🇮"),
        CountryPickerItem(countryName: "Albania", countryCode: "+355", flag: "🇦🇱"),
        CountryPickerItem(countryName: "Algeria", countryCode: "+213", flag: "🇩🇿"),
        CountryPickerItem(countryName: "American Samoa", countryCode: "+1684", flag: "🇦🇸"),
        CountryPickerItem(countryName: "Andorra", countryCode: "+376", flag: "🇦🇩"),
        CountryPickerItem(countryName: "Angola", countryCode: "+244", flag: "🇦🇴"),
        CountryPickerItem(countryName: "Antigua and Barbuda", countryCode: "+1268", flag: "🇦🇬"),
        CountryPickerItem(countryName: "Antarctica", countryCode: "+672", flag: "🇦🇶"),
        CountryPickerItem(countryName: "Argentina", countryCode: "+54", flag: "🇦🇷"),
        CountryPickerItem(countryName: "Armenia", countryCode: "+374", flag: "🇦🇲"),
        CountryPickerItem(countryName: "Aruba", countryCode: "+297", flag: "🇦🇼"),
        CountryPickerItem(countryName: "Ascension Island", countryCode: "+247", flag: "🇦🇨"),
        CountryPickerItem(countryName: "Australia", countryCode: "+61", flag: "🇦🇺"),
        CountryPickerItem(countryName: "Austria", countryCode: "+43", flag: "🇦🇹"),
        CountryPickerItem(countryName: "Azerbaijan", countryCode: "+994", flag: "🇦🇿"),
        CountryPickerItem(countryName: "Bahamas", countryCode: "+1242", flag: "🇧🇸"),
        CountryPickerItem(countryName: "Bahrain", countryCode: "+973", flag: "🇧🇭"),
        CountryPickerItem(countryName: "Bangladesh", countryCode: "+880", flag: "🇧🇩"),
        CountryPickerItem(countryName: "Barbados", countryCode: "+1246", flag: "🇧🇧"),
        CountryPickerItem(countryName: "Belarus", countryCode: "+375", flag: "🇧🇾"),
        CountryPickerItem(countryName: "Belgium", countryCode: "+32", flag: "🇧🇪"),
        CountryPickerItem(countryName: "Belize", countryCode: "+501", flag: "🇧🇿"),
        CountryPickerItem(countryName: "Benin", countryCode: "+229", flag: "🇧🇯"),
        CountryPickerItem(countryName: "Bermuda", countryCode: "+1441", flag: "🇧🇲"),
        CountryPickerItem(countryName: "Bhutan", countryCode: "+975", flag: "🇧🇹"),
        CountryPickerItem(countryName: "Bolivia", countryCode: "+591", flag: "🇧🇴"),
        CountryPickerItem(countryName: "Bosnia and Herzegovina", countryCode: "+387", flag: "🇧🇦"),
        CountryPickerItem(countryName: "Brazil", countryCode: "+55", flag: "🇧🇷"),
        CountryPickerItem(countryName: "British Indian Ocean Territory", countryCode: "+246", flag: "🇮🇴"),
        CountryPickerItem(countryName: "Brunei Darussalam", countryCode: "+673", flag: "🇧🇳"),
        CountryPickerItem(countryName: "Bulgaria", countryCode: "+359", flag: "🇧🇬"),
        CountryPickerItem(countryName: "Burkina Faso", countryCode: "+226", flag: "🇧🇫"),
        CountryPickerItem(countryName: "Burundi", countryCode: "+257", flag: "🇧🇮"),
        CountryPickerItem(countryName: "Cambodia", countryCode: "+855", flag: "🇰🇭"),
        CountryPickerItem(countryName: "Cameroon", countryCode: "+237", flag: "🇨🇲"),
        CountryPickerItem(countryName: "Canada", countryCode: "+1", flag: "🇨🇦"),
        CountryPickerItem(countryName: "Cape Verde", countryCode: "+238", flag: "🇨🇻"),
        CountryPickerItem(countryName: "Cayman Islands", countryCode: "+1345", flag: "🇰🇾"),
        CountryPickerItem(countryName: "Central African Republic", countryCode: "+236", flag: "🇨🇫"),
        CountryPickerItem(countryName: "Chad", countryCode: "+235", flag: "🇹🇩"),
        CountryPickerItem(countryName: "Chile", countryCode: "+56", flag: "🇨🇱"),
        CountryPickerItem(countryName: "China", countryCode: "+86", flag: "🇨🇳"),
        CountryPickerItem(countryName: "Christmas Island", countryCode: "+61", flag: "🇨🇽"),
        CountryPickerItem(countryName: "Colombia", countryCode: "+57", flag: "🇨🇴"),
        CountryPickerItem(countryName: "Comoros", countryCode: "+269", flag: "🇰🇲"),
        CountryPickerItem(countryName: "Congo", countryCode: "+242", flag: "🇨🇬"),
        CountryPickerItem(countryName: "Cook Islands", countryCode: "+682", flag: "🇨🇰"),
        CountryPickerItem(countryName: "Costa Rica", countryCode: "+506", flag: "🇨🇷"),
        CountryPickerItem(countryName: "Croatia", countryCode: "+385", flag: "🇭🇷"),
        CountryPickerItem(countryName: "Cuba", countryCode: "+53", flag: "🇨🇺"),
        CountryPickerItem(countryName: "Cyprus", countryCode: "+357", flag: "🇨🇾"),
        CountryPickerItem(countryName: "Czech Republic", countryCode: "+420", flag: "🇨🇿"),
        CountryPickerItem(countryName: "Democratic Republic of the Congo", countryCode: "+243", flag: "🇨🇩"),
        CountryPickerItem(countryName: "Denmark", countryCode: "+45", flag: "🇩🇰"),
        CountryPickerItem(countryName: "Djibouti", countryCode: "+253", flag: "🇩🇯"),
        CountryPickerItem(countryName: "Dominica", countryCode: "+1767", flag: "🇩🇲"),
        CountryPickerItem(countryName: "Sint Maarten", countryCode: "+1849", flag: "🇸🇽"),
        CountryPickerItem(countryName: "Ecuador", countryCode: "+593", flag: "🇪🇨"),
        CountryPickerItem(countryName: "Egypt", countryCode: "+20", flag: "🇪🇬"),
        CountryPickerItem(countryName: "El Salvador", countryCode: "+503", flag: "🇸🇻"),
        CountryPickerItem(countryName: "Equatorial Guinea", countryCode: "+240", flag: "🇬🇶"),
        CountryPickerItem(countryName: "Eritrea", countryCode: "+291", flag: "🇪🇷"),
        CountryPickerItem(countryName: "Estonia", countryCode: "+372", flag: "🇪🇪"),
        CountryPickerItem(countryName: "Eswatini", countryCode: "+268", flag: "🇸🇿"),
        CountryPickerItem(countryName: "Ethiopia", countryCode: "+251", flag: "🇪🇹"),
        CountryPickerItem(countryName: "Falkland Islands (Malvinas)", countryCode: "+500", flag: "🇫🇰"),
        CountryPickerItem(countryName: "Faroe Islands", countryCode: "+298", flag: "🇫🇴"),
        CountryPickerItem(countryName: "Fiji", countryCode: "+679", flag: "🇫🇯"),
        CountryPickerItem(countryName: "Finland", countryCode: "+358", flag: "🇫🇮"),
        CountryPickerItem(countryName: "France", countryCode: "+33", flag: "🇫🇷"),
        CountryPickerItem(countryName: "French Guiana", countryCode: "+594", flag: "🇬🇫"),
        CountryPickerItem(countryName: "French Polynesia", countryCode: "+689", flag: "🇵🇫"),
        CountryPickerItem(countryName: "Gabon", countryCode: "+241", flag: "🇬🇦"),
        CountryPickerItem(countryName: "Gambia", countryCode: "+220", flag: "🇬🇲"),
        CountryPickerItem(countryName: "Georgia", countryCode: "+995", flag: "🇬🇪"),
        CountryPickerItem(countryName: "Germany", countryCode: "+49", flag: "🇩🇪"),
        CountryPickerItem(countryName: "Ghana", countryCode: "+233", flag: "🇬🇭"),
        CountryPickerItem(countryName: "Greece", countryCode: "+30", flag: "🇬🇷"),
        CountryPickerItem(countryName: "Greenland", countryCode: "+299", flag: "🇬🇱"),
        CountryPickerItem(countryName: "Haiti", countryCode: "+509", flag: "🇭🇹"),
        CountryPickerItem(countryName: "Holy See", countryCode: "+379", flag: "🇻🇦"),
        CountryPickerItem(countryName: "Honduras", countryCode: "+504", flag: "🇭🇳"),
        CountryPickerItem(countryName: "Hong Kong", countryCode: "+852", flag: "🇭🇰"),
        CountryPickerItem(countryName: "Hungary", countryCode: "+36", flag: "🇭🇺"),
        CountryPickerItem(countryName: "Iceland", countryCode: "+354", flag: "🇮🇸"),
        CountryPickerItem(countryName: "India", countryCode: "+91", flag: "🇮🇳"),
        CountryPickerItem(countryName: "Indonesia", countryCode: "+62", flag: "🇮🇩"),
        CountryPickerItem(countryName: "Iran", countryCode: "+98", flag: "🇮🇷"),
        CountryPickerItem(countryName: "Italy", countryCode: "+39", flag: "🇮🇹"),
        CountryPickerItem(countryName: "Jamaica", countryCode: "+1876", flag: "🇯🇲"),
        CountryPickerItem(countryName: "Japan", countryCode: "+81", flag: "🇯🇵"),
        CountryPickerItem(countryName: "Jersey", countryCode: "+77", flag: "🇯🇪"),
        CountryPickerItem(countryName: "Kenya", countryCode: "+254", flag: "🇰🇪"),
        CountryPickerItem(countryName: "South Korea", countryCode: "+82", flag: "🇰🇷"),
        CountryPickerItem(countryName: "Kuwait", countryCode: "+965", flag: "🇰🇼"),
        CountryPickerItem(countryName: "Lebanon", countryCode: "+961", flag: "🇱🇧"),
        CountryPickerItem(countryName: "Liberia", countryCode: "+231", flag: "🇱🇷"),
        CountryPickerItem(countryName: "Libya", countryCode: "+218", flag: "🇱🇾"),
        CountryPickerItem(countryName: "Lithuania", countryCode: "+370", flag: "🇱🇹"),
        CountryPickerItem(countryName: "Macau", countryCode: "+853", flag: "🇲🇴"),
        CountryPickerItem(countryName: "Malaysia", countryCode: "+60", flag: "🇲🇾"),
        CountryPickerItem(countryName: "Mexico", countryCode: "+52", flag: "🇲🇽"),
        CountryPickerItem(countryName: "Mongolia", countryCode: "+976", flag: "🇲🇳"),
        CountryPickerItem(countryName: "Morocco", countryCode: "+212", flag: "🇲🇦"),
        CountryPickerItem(countryName: "Myanmar", countryCode: "+95", flag: "🇲🇲"),
        CountryPickerItem(countryName: "Namibia", countryCode: "+264", flag: "🇳🇦"),
        CountryPickerItem(countryName: "Nepal", countryCode: "+977", flag: "🇳🇵"),
        CountryPickerItem(countryName: "Netherlands", countryCode: "+31", flag: "🇳🇱")
    ]
}
