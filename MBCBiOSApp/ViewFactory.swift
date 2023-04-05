//
//  ViewFactory.swift
//  MBCBiOSApp
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com
//

import Foundation

struct ViewFactory {
    static func makeBalanceView() -> BalanceView {
        // let httpClient = HTTPClient()
        // let apiService = TransactionRemoteApiService(env: .production, httpClient: httpClient)
        // let apiService = TransactionRemoteApiService(env: .test, httpClient: httpClient)
        let apiService = TransactionMockApiService()
        
        let viewModel = BalanceViewModel(apiService: apiService)
        
        return BalanceView(viewModel: viewModel)
    }
}
