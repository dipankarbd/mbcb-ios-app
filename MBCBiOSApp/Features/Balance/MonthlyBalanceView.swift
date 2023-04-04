//
//  MonthlyBalanceView.swift
//  MBCBiOSApp
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com
//

import SwiftUI

struct MonthlyBalanceView: View {
    let items: [MonthlyBalance]
    
    var body: some View {
        List(items) { item in
            MonthlyBalanceRow(balance: item)
                .listRowSeparator(.hidden)
        }.listStyle(.plain)
    }
}

struct MonthlyBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyBalanceView(items: [MonthlyBalance(id: 1, month: "January", amount: 12.0), MonthlyBalance(id: 2, month: "January", amount:23.0)])
            .previewLayout(.sizeThatFits)
    }
}
