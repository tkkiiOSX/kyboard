//
//  kyboardApp.swift
//  kyboard
//
//  Created by Xcode2021 on 2022/01/09.
//

import SwiftUI

@main
struct kyboardApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.locale, Locale(identifier: "ja_JP"))
        }
    }
}
