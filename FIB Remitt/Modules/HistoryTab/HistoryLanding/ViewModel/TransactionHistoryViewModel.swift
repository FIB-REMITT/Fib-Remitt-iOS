
//
import SwiftUI
import Combine


class TransactionHistoryViewModel : ObservableObject{
    @Published var goToNext        = false
    
    @Published var destinationView = AnyView(Text("Destination"))
    @Published var transactionHistoryResponse: TransactionHistoryResponse?
    @Published var transactionHistoryDataOnly: [TransactionListContent] = []
    @Published var transactionDetails : TransactionDetailsResponse?
    
    @Published var selectedFilterValue : String = "All"
    
    
    private var subscribers = Set<AnyCancellable>()
    let repo = TransactionListRepository()
    
    
    func navigateToEditBankBeneficiary() {
        self.destinationView = AnyView(EditBeneficiaryBankView())
        self.goToNext        = true
    }
    
    
    func navigateToTransactionDetails(transactionNumber:String){
        self.destinationView = AnyView(HistoryDetailView(id: transactionNumber))
        self.goToNext        = true
    }
    
//    func transactionDetailsFetch(transactionNumber:String) {
//        repo.transactionDetailsApi(transactionNumber: transactionNumber)
//        repo.$transactionDetails.sink { result in
//            self.transactionDetails = result
//        }.store(in: &subscribers)
//    }
    
    func transactionDetailsFetch(transactionNumber: String) {
        repo.transactionDetailsApi(transactionNumber: transactionNumber)
        repo.$transactionDetails
            .sink { [weak self] result in
                self?.transactionDetails = result
            }
            .store(in: &subscribers)
    }

    
    func transactionListFetch(page:Int, from: String, to : String) {
        repo.transactionListApi(page:page ,from:from, to:to)
        repo.$transactionHistoryList.sink { result in
            self.transactionHistoryResponse = result
            self.transactionHistoryDataOnly =  self.transactionHistoryDataOnly + (result?.content ?? []) 
        }.store(in: &subscribers)
        
    }
}
