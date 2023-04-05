//
//  MBCBiOSAppApp.swift
//  MBCBiOSApp
//
//  Created by Dipankar Kumar Biswas
//  Email: dipankarbiswas@live.com
//

import SwiftUI

@main
struct noreda_mb_cb_iosApp: App {
    init() {
        let navBarAppearance = UINavigationBar.appearance()
         navBarAppearance.largeTitleTextAttributes = [.foregroundColor: UIColor(Color.theme.primaryDark)]
         navBarAppearance.titleTextAttributes = [.foregroundColor: UIColor(Color.theme.primaryDark)]
    }
    
    var body: some Scene {
        WindowGroup {
            ViewFactory.makeBalanceView()
        }
    }
}
