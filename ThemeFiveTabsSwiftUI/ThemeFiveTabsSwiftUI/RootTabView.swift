//
//  RootTabView.swift
//  ThemeFiveTabsSwiftUI
//
//  Created by Laurand Osmeni on 02/22/2026.
//  Built by Laurand Osmeni.
//

import SwiftUI
import Combine

struct RootTabView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        TabView {
            ProfileTabView()
                .tabItem {
                    Label("Profile", systemImage: "person.crop.circle")
                }

            GameTabView()
                .tabItem {
                    Label("Game", systemImage: "gamecontroller")
                }

            LeaderboardTabView()
                .tabItem {
                    Label("Leaders", systemImage: "list.number")
                }

            HistoryTabView()
                .tabItem {
                    Label("History", systemImage: "clock.arrow.circlepath")
                }

            SettingsTabView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .tint(appState.theme.accentColor)
        .background(appState.theme.backgroundTint)
    }
}
