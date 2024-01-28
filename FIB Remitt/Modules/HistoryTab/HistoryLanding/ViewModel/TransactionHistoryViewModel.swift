
//
import SwiftUI
import Combine


class TransactionHistoryViewModel : ObservableObject{
    @Published var goToNext        = false
    @Published var destinationView = AnyView(Text("Destination"))
    @Published var transactionHistoryDatas: [TransactionListContent] = []
   
    
    
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
    
    func transactionDetailsFetch(transactionNumber:String) {
            repo.transactionDetailsApi(transactionNumber: transactionNumber)
        }
    
    func transactionListFetch(page:Int) {
            repo.transactionListApi(page: page)
            repo.$transactionHistoryList.sink { result in
                self.transactionHistoryDatas = result?.content ?? []
            }.store(in: &subscribers)

        }
}
