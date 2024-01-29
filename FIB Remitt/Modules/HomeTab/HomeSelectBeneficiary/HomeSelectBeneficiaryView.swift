//
//  HomeSelectBeneficiaryView.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI
import UniformTypeIdentifiers

struct HomeSelectBeneficiaryView: View {
    @State var isSelected : Bool = true
    @State var isNotSelected : Bool = false
    @State var isFilePickerPresented = false
    @State private var isPickerShown = false
    
    @State private var selectedFileURL: URL?
    @ObservedObject var vm = HomeViewModel()
    
    var body: some View {
        
        let filePickerView = FilePickerView(
            isPickerShown: $isPickerShown,
            allowedContentTypes: [UTType.pdf],
            onSelect: { url in
                selectedFileURL = url
                print("Selected file: \(url)")
                isFilePickerPresented = false
            },
            onError: { error in
                print("Error: \(error.localizedDescription)")
            }
        )
        
        ZStack {
            
            VStack (spacing: 25){
                navigationBar
                topAccountCreation
                contexContainer
                Spacer()
                bottomButton
            }
            .padding()
            .background(Color.frBackground.ignoresSafeArea())
            .navigationBarHidden(true)
            .navigationDestination(isPresented: $vm.goToNext) {vm.destinationView}
            
            if isFilePickerPresented {
                // Blur background
                Color.black.opacity(0.4)
                    .edgesIgnoringSafeArea(.all)
                    .blur(radius: 3)
                    .onTapGesture {
                        filePickerView.hidePicker()
                        isFilePickerPresented = true
                    }
                
                // Your FilePickerCellView centered
                FilePickerCellView(selected: $isFilePickerPresented)
                    .onTapGesture {
                        filePickerView.showPicker()
                    }
                    .fileImporter(
                        isPresented: $isPickerShown,
                        allowedContentTypes: filePickerView.allowedContentTypes,
                        onCompletion: filePickerView.handleResult
                    )
            }
            
        }
        
    }
    
    
}

//MARK: - View Components
extension HomeSelectBeneficiaryView{
    private var navigationBar : some View {
        FRNavigationBarView(title: "Select Beneficiary", rightView: AnyView(FRBarButton(icon: "bell_ico", action: {self.notificationBtnPressed()})))
    }
    private var topAccountCreation : some View{
        HStack{
            TextBaseMedium(text: "Select Bank Account",fg_color: .textMute)
            Spacer()
            Button(action: { self.createAccountBtnPressed()}, label: {
                TextBaseMedium(text: "+Add New",fg_color: .primary500).underline()
            })}
    }
    private var contexContainer : some View{
        VStack{
            AccountInfoCellView(selected: $isSelected)
            AccountInfoCellView(selected: $isNotSelected)
                .onTapGesture {
                    isFilePickerPresented = true
                }
            AccountInfoCellView(selected: $isNotSelected)
            AccountInfoCellView(selected: $isNotSelected)
        }
    }
    private var bottomButton : some View{
        FRVerticalBtn(title: "Procced", btnColor: .primary500) {self.proccedBtnPressed()}
    }
}

//MARK: - ACTIONS
extension HomeSelectBeneficiaryView{
    private func createAccountBtnPressed() {
        
    }
    private func notificationBtnPressed() {
        
    }
    private func proccedBtnPressed() {
        vm.navigateToBeneficiarySummary()
    }
}

#Preview {
    HomeSelectBeneficiaryView()
}
