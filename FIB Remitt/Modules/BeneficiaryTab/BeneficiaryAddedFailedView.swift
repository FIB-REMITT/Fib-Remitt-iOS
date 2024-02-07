//
//  BeneficiaryAddedFailedView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 5/2/24.
//

import SwiftUI

struct BeneficiaryAddedFailedView: View {
    let width = UIScreen.main.bounds.width
    var body: some View {
        VStack(spacing: 20){
            Spacer()
            Image("success_tick")
                .imageDefaultStyle()
                .frame(width: width * 0.25)
            TextH4Medium(text: "Congratulation!", fg_color: .green)
            TextBaseRegular(text: "You have successfully added the Beneficiary", fg_color: .textFade)
                .padding(.horizontal)
                .multilineTextAlignment(.center)

            VStack(spacing:10){
                FRVerticalBtn(title:"OK", btnColor: .primary500) {}
                    .frame(width:80)

            }.padding()
            Spacer()
        }.navigationBarHidden(true)
    }
}

//MARK: - ACTIONS
extension BeneficiaryAddedFailedView{
//    func (<#parameters#>) -> <#return type#> {
//        <#function body#>
//    }
}

#Preview {
    BeneficiaryAddedFailedView()
}
