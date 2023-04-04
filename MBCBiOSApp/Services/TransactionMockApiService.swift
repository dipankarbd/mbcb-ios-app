//
//  TransactionMockApiService.swift
//  MBCBiOSApp
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com
//

import Foundation


struct TransactionMockApiService: TransactionApiService {
    func fetchTransactions() async throws -> [Transaction] {
        try await Task.sleep(nanoseconds: 2_000_000_000) // 2 sec delay
          
        if let path = Bundle.main.path(forResource: "transactions", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
                
                return try data.decode(dateDecodingStrategy: .formatted(formatter))
            } catch {
                throw ApiServiceError.invalidData
            }
        }
        
        throw ApiServiceError.unknown
    }
}


