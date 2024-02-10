//
//  FRBottomBarContainer.swift
//  IQDX
//
//  Created by Izak on 18/6/23.
//

import SwiftUI

struct FRBottomBarContainer: View {
    @EnvironmentObject var navTracker : NavTracker//()
    @State       var selected : TabBarItem
    
    init(selected:TabBarItem = TabBarItem.data.first!) {
        self.selected = selected
        UITabBar.appearance().isHidden = true
    }

    var body: some View {
        NavigationStack (path: $navTracker.navigationPath){
            VStack (spacing: 0){
                ZStack {
                    TabView(selection: $selected) {
                        AnyView( HomeRootView())
                            .tag(TabBarItem.data[0])
                        AnyView(BeneficiaryRootView())
                            .tag(TabBarItem.data[1])
//                        AnyView(SettingsRootView())
//                            .tag(TabBarItem.data[3])
                        AnyView(HistoryRootView())
                            .tag(TabBarItem.data[4])
                    }
                }
                FRBottomBar(tabs: [TabBarItem.data.first!, TabBarItem.data[1], TabBarItem.data[4]], selected: $selected)
                
            }.ignoresSafeArea(.keyboard,edges: .bottom)
            
        }
    }
}

struct XTabItemStack_Previews: PreviewProvider {
    @State static var dashboard : TabBarItem = TabBarItem.data.first!
    static var previews: some View {
        FRBottomBarContainer()
    }
}

struct TabBarItem:Hashable{
    let icon:String
    let title:String
    let color:Color
    
    static let data = [
        TabBarItem(icon: "home_ico", title: "Home", color: .blue),
        TabBarItem(icon: "beneficiary_ico", title: "Beneficiary", color: .red),
        TabBarItem(icon: "home_ico", title: "Trade", color: .blue),
        TabBarItem(icon: "settings_ico", title: "Settings", color: .orange),
        TabBarItem(icon: "history_ico", title: "History", color: .red),
    ]
}
