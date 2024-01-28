//
//  TransactionDetailsRepository.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 28/1/24.
//

import Combine
class TransactionDetailsRepository {
    private var subscribers = Set<AnyCancellable>()
    
    //@Published var loginInfo:SignInResponse?
  //  let vm = AuthViewModel()
    func transactionDetailsApi(transactionNumber: String)  {
        APIManager.shared.getData(endPoint: TransactionListEndpoint.TransactionDetails(transactionNumber: transactionNumber), resultType: TransactionDetailsResponse.self, showLoader: true)
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
                    print("API Called!")
                }
            } receiveValue: { result in
             
                if let data = result.transaction{
                    print(data)
//                        self.loginInfo = result
//                        UserSettings.shared.setLoginInfo(loginInfo: data)
                       // self.presenter?.loginDidAttempedWithSuccess()
                       // self.vm.successfullyLoggedIn()
                    }

               
            }.store(in: &subscribers)

    }
}
