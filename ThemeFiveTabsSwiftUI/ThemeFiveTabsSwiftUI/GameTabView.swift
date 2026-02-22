//
//  GameTabView.swift
//  ThemeFiveTabsSwiftUI
//
//  Created by Laurand Osmeni on 02/22/2026.
//  Built by Laurand Osmeni.
//  Tab 2: Simple game placeholder area with player summary and mute/unmute control.
//

import SwiftUI

struct GameTabView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            ContentWidthContainer {
                playerSummaryCard
                gamePlaceholderCard
            }
            .navigationTitle("Game")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        appState.gameMuted.toggle()
                        appState.addHistory(appState.gameMuted ? "Muted game" : "Unmuted game")
                        appState.speakIfEnabled(appState.gameMuted ? "Game muted" : "Game unmuted")
                    } label: {
                        Image(systemName: appState.gameMuted ? "speaker.slash.fill" : "speaker.wave.2.fill")
                    }
                    .accessibilityLabel(appState.gameMuted ? "Unmute" : "Mute")
                }
            }
            .onAppear {
                let nickname = appState.profile.nickname.isEmpty ? "Player" : appState.profile.nickname
                appState.speakIfEnabled("Game tab. Hello \(nickname).")
            }
        }
    }

    private var playerSummaryCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 12) {
                Text(appState.profile.avatarEmoji.isEmpty ? "🙂" : appState.profile.avatarEmoji)
                    .font(.system(size: 38))
                    .frame(width: 60, height: 60)
                    .background(Circle().fill(appState.theme.backgroundTint))

                VStack(alignment: .leading, spacing: 4) {
                    Text(appState.profile.nickname.isEmpty ? "Player" : appState.profile.nickname)
                        .font(.headline)
                    Text(appState.profile.location.isEmpty ? "No location set" : appState.profile.location)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }

            Divider()

            HStack {
                Label(appState.gameMuted ? "Muted" : "Sound On", systemImage: appState.gameMuted ? "speaker.slash" : "speaker.wave.2")
                Spacer()
                Text("Game Area")
                    .font(.subheadline.weight(.semibold))
                    .foregroundStyle(appState.theme.accentColor)
            }
            .font(.subheadline)
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var gamePlaceholderCard: some View {
        VStack(spacing: 14) {
            Image(systemName: "gamecontroller.fill")
                .font(.system(size: 42))
                .foregroundStyle(appState.theme.accentColor)

            Text("Simple Game Placeholder")
                .font(.title3.bold())

            Text("Use this space for your real game UI. This starter shows how to pass profile details and theme colors into a game screen.")
                .multilineTextAlignment(.center)
                .foregroundStyle(.secondary)

            Button {
                appState.addHistory("Tapped Start Game placeholder")
                appState.speakIfEnabled("Start game placeholder tapped")
            } label: {
                Text("Start Game")
                    .frame(maxWidth: 260)
                    .frame(height: 44)
            }
            .buttonStyle(.borderedProminent)
            .tint(appState.theme.accentColor)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18))
    }
}
