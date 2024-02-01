import SwiftUI
import Combine

struct FibPaymentCheckView: View {
    @State private var secondsRemaining = 60
    @State private var isLoading = false
    @ObservedObject var vm = HomeViewModel()
    @State private var navigateToFailedView = false
    @State private var areTimersRunning = true

    private let timerPublisher = Timer.publish(every: 5, on: .main, in: .common).autoconnect()

    var body: some View {
        VStack {
            TextH6Medium(text: "Waiting for vaildate the transaction", fg_color: .primary500)
            TextBaseRegular(text: "Ramaining: \(secondsRemaining) seconds", fg_color: .primary500)
                .padding()
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle(tint: .primary500))
                        .scaleEffect(2.0) // Increase the scale factor to make it bigger
                        .padding()
            }
        }
        .navigationBarHidden(true)
        .navigationDestination(isPresented: $vm.goToNext, destination: { vm.destinationView })
        .onAppear {
            startTimers()
        }
        .onDisappear {
            stopTimers()
        }
        .onReceive(timerPublisher, perform: { _ in
            if areTimersRunning {
                paymentCheckApiCall()
                if vm.PaymentConfirmationResponse?.status == true{
                    navigateToSuccessDialogue()
                }
            }
        })
        .onChange(of: vm.PaymentConfirmationResponse) { value in
            if value?.status == true{
                navigateToSuccessDialogue()
            }
        }
    }
    
    
    func navigateToSuccessDialogue(){
       
        isLoading = false
        areTimersRunning = false
        vm.navigateToSuccessfulView()
    }

    func startTimers() {
        isLoading = true
      
        areTimersRunning = true
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if secondsRemaining > 0 {
                secondsRemaining -= 1
            } else {
                timer.invalidate()
                isLoading = false
                areTimersRunning = false
                vm.navigateToFailedView()
            }
        }
    }

    func stopTimers() {
        areTimersRunning = false
    }

    func paymentCheckApiCall() {
        vm.paymentCheck(trxId: HomeDataHandler.shared.beneficiaryCollectionResponse?.transactionNumber ?? "")
    }
}

extension FibPaymentCheckView {
    private var navigationBar: some View {
        FRNavigationBarView(title: "FIB payment check")
    }
}

struct FibPaymentCheckView_Previews: PreviewProvider {
    static var previews: some View {
        FibPaymentCheckView()
    }
}
