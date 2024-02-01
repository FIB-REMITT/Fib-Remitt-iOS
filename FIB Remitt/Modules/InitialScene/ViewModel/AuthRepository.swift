//
//  Repository.swift
//  FIB Remitt
//
//  Created by Izak on 28/1/24.
//

import Combine

class AuthRepository {
    private var subscribers = Set<AnyCancellable>()
    
    @Published var loginInfo: SignInResponse?
    @Published var authWithFIBResponse: SignInData?

    func loginAPICall(username:String, pass:String)  {
        APIManager.shared.getData(endPoint: AuthEndPoint.signIn(username: username, password: pass), resultType: SignInResponse.self, showLoader: true)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    if let err = error as? NetworkError{
                        // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: true)
                    }else{
                       // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: false)
                    }
                 
                case .finished:
                    print("API Called!")
                }
            } receiveValue: { result in
                if result.data?.access_token == nil{
                }else{
                    if let data = result.data{
                        self.loginInfo = result
                        UserSettings.shared.setLoginInfo(loginInfo: data)
                    }

                }
            }.store(in: &subscribers)
    }
    
    func ssoLoginAPICall(code: String)  {
        APIManager.shared.getData(apiUrl: "https://fib.stage.fib.iq/",endPoint: AuthEndPoint.ssoLogin(code: code), resultType: SignInData.self, showLoader: true)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    if error is NetworkError{
                        // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: true)
                    }else{
                       // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: false)
                    }
                 
                case .finished:
                    print("API Called!")
                }
            } receiveValue: { result in
                self.authWithFIBAPICall(idToken: result.id_token ?? "", accessToken: result.access_token ?? "")
            }.store(in: &subscribers)
    }
    
    func authWithFIBAPICall(idToken:String, accessToken:String)  {
        APIManager.shared.getData(endPoint: AuthEndPoint.authWithFIB(idToken: idToken, accessToken: accessToken), resultType: SignInData.self, showLoader: true)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    if error is NetworkError{
                        // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: true)
                    }else{
                       // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: false)
                    }
                 
                case .finished:
                    print("API Called!")
                }
            } receiveValue: { result in
                self.authWithFIBResponse = result
                UserSettings.shared.setLoginInfo(loginInfo: result)
                UserSettings.shared.jwtToken(token: self.authWithFIBResponse?.access_token ?? "")
                if result.access_token?.isEmpty == false{
                    loadView(view:  FRBottomBarContainer())
                }
            }.store(in: &subscribers)
    }
    
}
