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
            let zoom = webView.bounds.size.width * 6
            webView.scrollView.setZoomScale(zoom, animated: false)
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
    @State var webViewShouldShow = true
    var body: some View {
        //        WebLoginView(url: URL(string: urlLink)!) { url in
        //            self.redirectURL = url
        //        }
        HStack(alignment:.top){
            if webViewShouldShow{
                WebLoginView(url: URL(string: urlLink)!,scale: 4.0, redirectModel: redirectModel)
                    .onReceive(redirectModel.$redirectURL, perform: { url in
                        let urlStr: String = url?.absoluteString ?? ""
                        if urlStr.contains(Constant.redirect_url) && urlStr.contains("code="){
                            self.webViewShouldShow = false
                            let code = urlStr.split(separator: "code=")
                            print("Here is the code = \(code[1])")
                            viewModel.ssoLogin(code: String(code[1]))
                            return
                            
                        }
                        print("Here is the urls: \(String(describing: url))")
                    })
            }else{
                VStack{}
            }
            
        }//.frame(width: UI.scnWidth * 1.1)
    }
}

#Preview {
    WebContentView()
}
