//
//  ApiServiceError.swift
//  MBCBiOSApp
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com
//

import Foundation

enum ApiServiceError: Error, LocalizedError {
    case networkError
    case invalidData
    case unknown
    
    var errorDescription: String? {
        switch self {
        case .networkError:
            return NSLocalizedString("networkError", comment: "")
        case .invalidData:
            return NSLocalizedString("invalidData", comment: "")
        case .unknown:
            return NSLocalizedString("unknownError", comment: "")
        }
    }
}
