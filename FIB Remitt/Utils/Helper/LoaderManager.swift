//
//  LoaderManager.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 25/1/24.
//

import SwiftUI

class LoaderManager:ObservableObject{
    static var shared = LoaderManager()
    var isLoading = false
    
    let hud = UIHostingController(rootView: FIBLoaderView())
    
    //Progress Hud
    func showHud() {
        
        if self.isLoading{return}
        
        hud.modalPresentationStyle = .overFullScreen
        hud.modalTransitionStyle = .crossDissolve
        hud.view.backgroundColor = .clear
        
        if isLoaderInactive(){
            getWindow().rootViewController?.present(self.hud, animated: true)
        }
        
        isLoading = true
    }
    
    func hideHud(after:Double = 0.0) {
        if isLoading{
            DispatchQueue.main.asyncAfter(deadline: .now() + after) {
                self.hud.dismiss(animated: false, completion: { self.isLoading = false })
            }
        }
    }
    
    func isLoaderInactive() -> Bool {
        return !(getWindow().rootViewController?.presentedViewController == hud)
    }
    
    private init() {}
}
