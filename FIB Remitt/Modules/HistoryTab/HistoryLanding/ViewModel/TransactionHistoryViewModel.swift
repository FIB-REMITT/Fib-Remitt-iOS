
//
import SwiftUI
import Combine


class TransactionHistoryViewModel : ObservableObject{
    @Published var goToNext        = false
    @Published var destinationView = AnyView(Text("Destination"))
    @Published var transactionHistoryDatas: [TransactionListContent] = []
    
    
    private var subscribers = Set<AnyCancellable>()
    let repo = TransactionListRepository()
    
    func navigateToTransactionHistoryDetail() {
       self.destinationView = AnyView(HistoryDetailView())
       self.goToNext        = true
   }
    
    func navigateToEditBankBeneficiary() {
       self.destinationView = AnyView(EditBeneficiaryBankView())
       self.goToNext        = true
   }
    
    
    func navigateToTransactionDetails() {
       self.destinationView = AnyView(HistoryDetailView())
       self.goToNext        = true
   }
    
    func transactionListFetch(page:Int) {
            repo.transactionListApi(page: page)
            repo.$transactionHistoryList.sink { result in
                self.transactionHistoryDatas = result?.content ?? []
            }.store(in: &subscribers)

        }
}
