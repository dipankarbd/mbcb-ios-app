//
//  TransactionRemoteApiService.swift
//  MBCBiOSApp
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com
//

import Foundation


struct TransactionRemoteApiService: TransactionApiService {
    enum Environment: String {
        case production = "https://api.somewebsite.com"
        case test = "https://api-test.somewebsite.com"
    }
    
    private var env: Environment
    private var httpClient: HTTPClientProtocol
    
    init(env: Environment = .production, httpClient: HTTPClientProtocol) {
        self.env = env
        self.httpClient = httpClient
    }
    
    func fetchTransactions() async throws -> [Transaction] {
        let urlsStr = "\(env.rawValue)/transactions"
        let url = URL(string: urlsStr)!
        print("request url: \(url)")
        
        
        let headers = ["Content-Type": "application/json"]
        
        do {
            let (statusCode, data) =  try await httpClient.sendGetHTTPRequest(url: url, headers: headers, data: nil)
            
            if statusCode != 200 {
                throw ApiServiceError.networkError
            }
            
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.000Z"
            
            return try data.decode(dateDecodingStrategy: .formatted(formatter))
        } catch DataError.decodingError {
            throw ApiServiceError.invalidData
        } catch {
            throw ApiServiceError.networkError
        }
    }
    
}


