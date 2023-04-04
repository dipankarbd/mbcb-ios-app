
//
//  CumulativeBalanceView.swift
//  MBCBiOSApp
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com
//

import SwiftUI

struct CumulativeBalanceView: View {
    let amount: Decimal
    var body: some View {
        VStack(alignment: .center, spacing: 8) {
            Text("cumulativeBalance")
                .foregroundColor(Color.theme.text2)
            Text(amount.formatted(.currency(code: "EUR")))
                .foregroundColor(Color.theme.text1)
                .fontWeight(.bold)
        }
        .frame(maxWidth: .infinity)
        .padding()
        .background(Color.theme.primaryLight)
        .cornerRadius(8)
        .padding()
    }
}

struct CumulativeBalanceView_Previews: PreviewProvider {
    static var previews: some View {
        CumulativeBalanceView(amount: 1000.23)
            .previewLayout(.sizeThatFits)
    }
}
