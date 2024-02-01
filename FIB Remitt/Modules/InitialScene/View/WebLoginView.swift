//
//  WebLoginView.swift
//  FIB Remitt
//
//  Created by Jamil Hasnine on 30/1/24.
//

import SwiftUI
import WebKit

class RedirectModel: ObservableObject{
    @Published var redirectURL: URL?
}

struct WebLoginView: UIViewRepresentable {
    
    let url : URL
    let scale: CGFloat
    
    @ObservedObject var redirectModel: RedirectModel
    
    func updateUIView(_ uiView: WKWebView, context: Context) {
        
    }
    
    
    func makeUIView(context: Context) -> WKWebView{
        let webView = WKWebView()
        webView.navigationDelegate = context.coordinator
        webView.load(URLRequest(url: url))
        return webView
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(redirectModel: redirectModel)
    }
    
    class Coordinator: NSObject, WKNavigationDelegate{
        let redirectModel: RedirectModel
        
        init(redirectModel: RedirectModel) {
            self.redirectModel = redirectModel
        }
        
        
        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
                    // JavaScript to set the username (phone number) and password
                    let phoneNumber = "7854545454"  // Replace with the actual phone number
                    let password = "Ibrahim1997"   // Replace with the actual password
                    let script = """
                        document.getElementById('username').value = '\(phoneNumber)';
                        document.getElementById('password').value = '\(password)';
                        // Optionally, you can submit the form if needed
                        // document.getElementById('loginForm').submit();
                    """

                    webView.evaluateJavaScript(script) { result, error in
                        if let error = error {
                            print("JavaScript execution error: \(error)")
                        } else {
                            print("JavaScript executed successfully")
                        }
                    }
                }
        
        func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
    
            guard let redirectURL = navigationAction.request.url else {
                decisionHandler(.cancel)
                return
            }
            redirectModel.redirectURL = redirectURL
            decisionHandler(.allow)
        }
    }
    
    
}

struct WebContentView: View {
    @StateObject private var redirectModel = RedirectModel()
    @ObservedObject var viewModel = AuthViewModel()
    let urlLink = "https://fib.stage.fib.iq/auth/realms/fib-business-application/protocol/openid-connect/auth?redirect_uri="+Constant.redirect_url+"&response_type=code&client_id=sso-fib-pos&scope=openid"
    var body: some View {
        //        WebLoginView(url: URL(string: urlLink)!) { url in
        //            self.redirectURL = url
        //        }
        HStack(alignment:.top){
            WebLoginView(url: URL(string: urlLink)!,scale: 4.0, redirectModel: redirectModel)
                .onReceive(redirectModel.$redirectURL, perform: { url in
                    
                    let urlStr: String = url?.absoluteString ?? ""
                    if urlStr.contains(Constant.redirect_url) && urlStr.contains("code="){
                        let code = urlStr.split(separator: "code=")
                        print("Here is the code = \(code[1])")
                        viewModel.ssoLogin(code: String(code[1]))
                        return
                        
                    }
                    print("Here is the urls: \(String(describing: url))")
                })
            
        }//.frame(width: UI.scnWidth * 1.1)
    }
}

#Preview {
    WebContentView()
}
