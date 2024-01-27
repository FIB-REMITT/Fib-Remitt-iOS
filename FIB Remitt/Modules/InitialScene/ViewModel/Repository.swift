//
//  Repository.swift
//  FIB Remitt
//
//  Created by Izak on 28/1/24.
//

import Combine

class AuthRepository {
    private var subscribers = Set<AnyCancellable>()
    
    @Published var loginInfo:SignInResponse?
    let vm = AuthViewModel()
    func loginAPICall(username:String, pass:String)  {
        APIManager.shared.getData(endPoint: AuthEndPoint.signIn(username: username, password: pass), resultType: SignInResponse.self, showLoader: true)
            .sink { completion in
                switch completion{
                case .failure(let error):
                    print(error.localizedDescription)
                    if let err = error as? NetworkError{
                        //self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: true)
                    }else{
                       // self.presenter?.loginDidAttempedWithError(errorMsg: error.localizedDescription,toast: false)
                    }
                 
                case .finished:
                    print("API Called!")// kabbo+81@newroztech.com //Password100@
                }
            } receiveValue: { result in
                if result.data?.access_token == nil{
                    //self.presenter?.loginDidAttempedWithTwoFactorRequired()
                }else{
                    if let data = result.data{
                        self.loginInfo = result
                        UserSettings.shared.setLoginInfo(loginInfo: data)
                       // self.presenter?.loginDidAttempedWithSuccess()
                        self.vm.successfullyLoggedIn()
                    }

                }
            }.store(in: &subscribers)

    }
}
