//
//  FRCircularRadioButton.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI

struct FRCircularRadioButton: View {
    
    @Binding var isSelected : Bool
    var title : String = "Bank Transfer"
    var radioColor = Color.primary_500
    var body: some View {
        HStack(alignment: .center, spacing: 13){
            Toggle("", isOn: $isSelected)
                .toggleStyle(CircularRadioButtonStyle(size: 22, color: radioColor))
            
            Text(title)
                .font(UI.FRAppDesignedFont(style: .baseRegular))
                .foregroundColor(Color.textFade)

            Spacer()
        }
        .frame(maxHeight: 36)
    }
}



struct FRCircularRadioButton_Previews: PreviewProvider {
    @State static var selection = true
    
    static var previews: some View {
        FRCircularRadioButton(isSelected: $selection)
    }
}

struct CircularRadioButtonStyle: ToggleStyle {
    let size: CGFloat
    let color: Color
    func makeBody(configuration: Configuration) -> some View {
        Button(action: {
            configuration.isOn.toggle()
        }) {
            ZStack {
                if configuration.isOn {
                    Image("radio_on")
                        .frame(width: size, height: size)
                        .foregroundColor(Color.primary500)
                }else{
                    Image("radio_off")
                        .frame(width: size, height: size)
                        .foregroundColor(Color.text_Mute)
                }
            }
        }
    }
}
