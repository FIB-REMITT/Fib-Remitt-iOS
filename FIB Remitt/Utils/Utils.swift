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

func getWindow() -> UIWindow{
    let windows = UIApplication.shared.connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
    if let window = windows.first(where: { $0.isKeyWindow }) {
        return window
    }else{
        return UIWindow()
    }
}
