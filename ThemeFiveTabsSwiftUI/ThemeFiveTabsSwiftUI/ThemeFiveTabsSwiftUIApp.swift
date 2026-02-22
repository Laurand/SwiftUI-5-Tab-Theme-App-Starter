//
//  ThemeFiveTabsSwiftUIApp.swift
//  ThemeFiveTabsSwiftUI
//
//  Created by Laurand Osmeni on 02/22/2026.
//  Built by Laurand Osmeni.
//  A clean 5-tab SwiftUI starter with theme switching, accessibility speech, and structured screens.
//

import SwiftUI
import Combine

@main
struct ThemeFiveTabsSwiftUIApp: App {
    @StateObject private var appState = AppState()

    var body: some Scene {
        WindowGroup {
            RootTabView()
                .environmentObject(appState)
                .preferredColorScheme(appState.theme.preferredColorScheme)
        }
    }
}
