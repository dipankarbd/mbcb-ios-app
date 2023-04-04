//
//  BalanceViewModel.swift
//  MBCBiOSApp
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com
//

import Foundation
import Combine

class BalanceViewModel: ObservableObject {
    @Published var cumulativeBalance: Decimal = 0.0
    @Published var monthlyBalance: [MonthlyBalance] = []
    @Published var isLoading: Bool = false
    @Published var showAlert: Bool = false
    @Published var errorMessage: String?
    
    private var apiService: TransactionApiService
    
    init(apiService: TransactionApiService) {
        self.apiService = apiService
    }
    
    @MainActor
    func fetchTransactions() async {
        do {
            self.isLoading = true
            
            let transactions =  try await apiService.fetchTransactions()
            
            cumulativeBalance = Utils.calculateCumulativeBalance(transactions: transactions)
            monthlyBalance = Utils.calculateMAB(transactions: transactions)
             
            self.isLoading = false
            
        } catch {
            self.isLoading = false
            self.showAlert = true
            self.errorMessage = error.localizedDescription
        }
        
    }
}
