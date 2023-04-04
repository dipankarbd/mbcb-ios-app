//
//  TransactionApiService.swift
//  MBCBiOSApp
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com
//

import Foundation

protocol TransactionApiService {
    func fetchTransactions() async throws -> [Transaction]
}
