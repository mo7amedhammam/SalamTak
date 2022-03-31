//
//  SalamTechApp.swift
//  SalamTech
//
//  Created by wecancity agency on 3/29/22.
//

import SwiftUI

@main
struct SalamTechApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        let resign = #selector(UIResponder.resignFirstResponder)
                UIApplication.shared.sendAction(resign, to: nil, from: nil, for: nil)
    }
}
#endif
