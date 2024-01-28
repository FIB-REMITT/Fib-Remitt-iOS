//
//  TransactionListRepository.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 28/1/24.
//

import Combine

class TransactionListRepository {
    private var subscribers = Set<AnyCancellable>()
    
    @Published var loginInfo:SignInResponse?
  //  let vm = AuthViewModel()
    func transactionListApi()  {
        APIManager.shared.getData(endPoint: TransactionListEndpoint.TransactionList, resultType: TransactionHistoryResponse.self, showLoader: true)
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
             
                if let data = result.content{
                    print(data)
//                        self.loginInfo = result
//                        UserSettings.shared.setLoginInfo(loginInfo: data)
                       // self.presenter?.loginDidAttempedWithSuccess()
                       // self.vm.successfullyLoggedIn()
                    }

               
            }.store(in: &subscribers)

    }
}
