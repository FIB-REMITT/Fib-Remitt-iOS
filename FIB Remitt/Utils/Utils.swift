//
//  Utils.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI


func hideKeyboard(){UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)}

func hideSheet( after:Double = 0.0) {
    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
        getWindow().rootViewController?.dismiss(animated: true)}
}

func getInitialView() -> AnyView {
//    if let isUserLoggedIn = UserSettings.shared.isUserLoggedIn{
//        if isUserLoggedIn{
            return AnyView(FRBottomBarContainer())
//        }else{
//            return AnyView(LandingRouter.start().entry!)
//        }
//    }else{
//        return AnyView(LandingRouter.start().entry!)
//    }
}

func getWindow() -> UIWindow{
    let windows = UIApplication.shared.connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
    if let window = windows.first(where: { $0.isKeyWindow }) {
        return window
    }else{
        return UIWindow()
    }
}
