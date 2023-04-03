//
//  Transaction.swift
//  MBCBiOSApp
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com.
//

import Foundation

struct Transaction: Codable, Identifiable {
    let id: Int
    let amount: Decimal
    let description: String
    let date: Date
}

