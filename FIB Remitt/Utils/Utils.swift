//
//  Utils.swift
//  FIB Remitt
//
//  Created by Ainul Kazi on 22/1/24.
//

import SwiftUI


//Show alert Dialog
func showAlert(title:String = "Alert!", message: String) {

//    let alert = UIHostingController(rootView: XAleart(title: title, message: message, action: {hideSheet()}))
//    alert.modalPresentationStyle = .overFullScreen
//    alert.modalTransitionStyle = .crossDissolve
//    alert.view.backgroundColor = .clear
//    
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//        getWindow().rootViewController?.present(alert, animated: false)
//    }
}

func showAlert(title:String = "Alert!", message: String, after:Double) {

//    let alert = UIHostingController(rootView: XAleart(title: title, message: message, action: {hideSheet()}))
//    alert.modalPresentationStyle = .overFullScreen
//    alert.modalTransitionStyle = .crossDissolve
//    alert.view.backgroundColor = .clear
//    
//    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
//        getWindow().rootViewController?.present(alert, animated: false)
//    }
}

//Show aleart with Action
func showAlert(title:String = "Alert!",message: String, perform:@escaping ()->Void) {

//    let alert = UIHostingController(rootView: XAleart(title:title, message: message, action: {perform()}))
//    alert.modalPresentationStyle = .overFullScreen
//    alert.modalTransitionStyle = .crossDissolve
//    alert.view.backgroundColor = .clear
//    
//    DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
//        getWindow().rootViewController?.present(alert, animated: false)
//    }
}

//Show aleart with Action
func showAlertWithAction(title:String = "Alert!",message: String, after:Double = 0.2, perform:@escaping ()->Void) {
//
//    let alert = UIHostingController(rootView: XAleartTwoBtn(title:title, message: message, secondBtnAction: {perform()}))
//    alert.modalPresentationStyle = .overFullScreen
//    alert.modalTransitionStyle = .crossDissolve
//    alert.view.backgroundColor = .clear
//    
//    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
//        getWindow().rootViewController?.present(alert, animated: false)
//    }
}
func hideKeyboard(){UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)}

func hideSheet( after:Double = 0.0) {
    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
        getWindow().rootViewController?.dismiss(animated: true)}
}


func showSheet(view: AnyView, isFullScreen: Bool = false) {
    let vc = UIHostingController(rootView: view)
    if isFullScreen { vc.modalPresentationStyle = .overFullScreen }
    vc.view.backgroundColor = UIColor.clear
    getWindow().rootViewController?.present(vc, animated: true)
}

func showSheet(view: AnyView, after:Double) {
    let vc = UIHostingController(rootView: view)
    //    vc.modalPresentationStyle = .overFullScreen
    vc.view.backgroundColor = UIColor.clear
    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
        getWindow().rootViewController?.present(vc, animated: true)
    }
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

func formatDateString(incomingFormate :String = "yyyy-MM-dd'T'HH:mm:ss.SSSZZZZZ",dateString: String, convertFormat: String) -> String? {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = incomingFormate
    
    if let date = dateFormatter.date(from: dateString) {
        dateFormatter.dateFormat = convertFormat
        return dateFormatter.string(from: date)
    }
    
    return nil // Return nil for invalid input
}


func showToast(message : String, font: UIFont = .systemFont(ofSize: 14), after:Double = 0.0, isTopToast:Bool = false) {
    let scnSize = UIScreen.main.bounds
    let xCoOrdinate = scnSize.width * 0.10
    var yCoOrdinate = scnSize.height * 0.4
    if isTopToast{
         yCoOrdinate = scnSize.height * 0.05
    }
    let width = scnSize.width * 0.80
    
    let toastLabel = UILabel(frame: CGRect(x: xCoOrdinate, y: yCoOrdinate, width: width, height: 35))
    toastLabel.backgroundColor = UIColor.white.withAlphaComponent(0.9)
    toastLabel.textColor = UIColor.black
    toastLabel.font = font
    toastLabel.textAlignment = NSTextAlignment.center;
    toastLabel.text = message
    toastLabel.numberOfLines = 0
    toastLabel.lineBreakMode = .byWordWrapping
    let expectedHeight = toastLabel.sizeThatFits(toastLabel.bounds.size).height
    toastLabel.frame = CGRect(x: xCoOrdinate, y: yCoOrdinate, width: width, height: expectedHeight + 20)
    toastLabel.alpha = 1.0
    toastLabel.layer.cornerRadius = 6
    toastLabel.clipsToBounds  =  true
    
    DispatchQueue.main.asyncAfter(deadline: .now() + after) {
        getWindow().rootViewController?.view.addSubview(toastLabel)
        UIView.animate(withDuration: 4.0, delay: 2.0, options: .curveEaseOut, animations: {
            toastLabel.alpha = 0.0
        }, completion: {(isCompleted) in
            toastLabel.removeFromSuperview()
        })
    }
}

func loadView(view: some View) {
    // Get the windows associated with the currently connected scenes
    let windows = UIApplication.shared.connectedScenes
        .flatMap { ($0 as? UIWindowScene)?.windows ?? [] }
    
    if let window = windows.first(where: { $0.isKeyWindow }) {
        let hostingController = UIHostingController(rootView: view)
        window.rootViewController = hostingController
        window.makeKeyAndVisible()
    }
}
