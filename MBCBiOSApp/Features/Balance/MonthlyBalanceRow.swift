//
//  MonthlyBalanceRow.swift
//  MBCBiOSApp
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com
//

import SwiftUI

struct MonthlyBalanceRow: View {
    let balance: MonthlyBalance
    
    var body: some View {
        HStack(spacing: 8) {
            Text(balance.month)
                .foregroundColor(Color.theme.text1)
            Spacer()
            Text(balance.amount.formatted(.currency(code: "EUR")))
                .foregroundColor(Color.theme.text3)
                .fontWeight(.bold)
        }
        .padding()
        .background(Color.theme.primaryLight)
        .cornerRadius(8)
    }
}

struct MonthlyBalanceRow_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyBalanceRow(balance: MonthlyBalance(id: 1, month: "January", amount: 0.0))
            .previewLayout(.sizeThatFits)
    }
}

