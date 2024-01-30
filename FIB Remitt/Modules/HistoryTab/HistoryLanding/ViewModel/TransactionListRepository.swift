//
//  TransactionListRepository.swift
//  FIB Remitt
//
//  Created by Sabbir Nasir on 28/1/24.
//

import Combine

class TransactionListRepository {
    private var subscribers = Set<AnyCancellable>()
    
    @Published var transactionHistoryList : TransactionHistoryResponse?
    
    @Published var transactionDetails : TransactionDetailsResponse?
    
    
    
    func transactionListApi(page:Int, from:String,to:String)  {
        APIManager.shared.getData(endPoint: TransactionListEndpoint.TransactionList(page: page,from:from,to: to), resultType: TransactionHistoryResponse.self, showLoader: true)
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
                    self.transactionHistoryList = result
                }
                
                
            }.store(in: &subscribers)
        
    }
    
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
                    print("API Called!!")
                }
            } receiveValue: { result in
                
                if result != nil {
                    self.transactionDetails = result
                }
                
                
            }.store(in: &subscribers)
        
    }
}
