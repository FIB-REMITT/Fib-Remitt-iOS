//
//  FRBottomBar.swift
//  IQDX
//
//  Created by Izak on 18/6/23.
//

import SwiftUI

struct FRBottomBar: View {
    let tabs:[TabBarItem]
    @Binding var selected:TabBarItem
    
    var body: some View {
        HStack {
            ForEach(tabs, id: \.self) { tab in
                if tab.title == "Trade"{
                    centerTabView(tab)
                }else{
                    tabView(tab)
                }
            }
        }
        .padding(6)
        .background(Color.fr_forground.edgesIgnoringSafeArea(.bottom))
        .shadow(color: .white, radius: 4)
    }
}

extension FRBottomBar{
    func tabView(_ tab:TabBarItem) -> some View {
        VStack {
            Image(selected == tab ? "\(tab.icon)_selected" :  tab.icon)
                .font(.subheadline)
                .scaleEffect(selected == tab ? 1.1 : 1)
            
            Text(tab.title)
                .font(.system(size: 10, weight: .semibold, design: .rounded))
                .scaleEffect(selected == tab ? 1.1 : 1)
        }
        .foregroundColor(selected == tab ? Color.primary_500 : Color.text_Mute)
        .padding(.vertical, 8)
        .frame(maxWidth: .infinity)
        .cornerRadius(6)
        .onTapGesture {
            switchToTab(tab)
        }
    }
    
    func centerTabView(_ tab:TabBarItem) -> some View {
        ZStack {
            Image(tab.icon)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(15)
                .background(Color.primary500)
                .cornerRadius(40)
                .offset(y:-25)
                .scaleEffect(selected == tab ? 1.1 : 1)
                .onTapGesture {switchToTab(tab)}
            
            VStack {
                Image("house_ico")
                    .font(.subheadline)
                    .foregroundColor(.clear)
                    .background(Color.clear)
                    .scaleEffect(selected == tab ? 1.1 : 1)
                
                Text(tab.title)
                    .font(.system(size: 10, weight: .semibold, design: .rounded))
                    .scaleEffect(selected == tab ? 1.1 : 1)
            }
            .tabItemStyle(isSelected: tab == selected)
            .onTapGesture {switchToTab(tab)}
        }
    }
    
    func switchToTab(_ tab:TabBarItem) {
        withAnimation(.easeOut) {
            selected = tab
        }
    }
}

//struct XBottomBar_Previews: PreviewProvider {
//    @State static var selected:TabBarItem = TabBarItem.data.first!
//    static var previews: some View {
//        XBottomBar(tabs: [TabBarItem.data.first!, TabBarItem.data[1]], selected: $selected)
//    }
//}
