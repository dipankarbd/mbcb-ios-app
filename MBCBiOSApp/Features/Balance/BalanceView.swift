//
//  BalanceView.swift
//  MBCBiOSApp
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com
//

import SwiftUI

struct BalanceView: View {
    @StateObject var viewModel: BalanceViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    loadingView
                } else {
                   CumulativeBalanceView(amount: viewModel.cumulativeBalance)
                   MonthlyBalanceView(items: viewModel.monthlyBalance)
                }
            }
            .alert("errorAlertTitle", isPresented: $viewModel.showAlert, actions: {
                Button("ok") {}
            }, message: {
                if let errorMessage = viewModel.errorMessage {
                    Text(errorMessage)
                }
            })
            .navigationTitle("balanceDemo")
            .navigationBarItems(trailing: reloadButton)
        }
        .task {
            await viewModel.fetchTransactions()
        }
    }
}

extension BalanceView {
    var loadingView: some View {
        VStack() {
            Spacer()
            HStack {
                Spacer()
                ProgressView("pleaseWaitMessage")
                    .progressViewStyle(.circular)
                    .scaleEffect(1.5)
                Spacer()
            }
            Spacer()
        }
    }
    
    var reloadButton: some View {
        Button(action: {
            Task {
                await viewModel.fetchTransactions()
            }
        }) {
            Image(systemName: "arrow.clockwise")
        }
    }
}

struct BalanceView_Previews: PreviewProvider {
    static var previews: some View {
        BalanceView(viewModel: BalanceViewModel(apiService: TransactionMockApiService()))
    }
}
