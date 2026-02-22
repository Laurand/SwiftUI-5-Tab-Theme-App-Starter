//
//  LeaderboardTabView.swift
//  ThemeFiveTabsSwiftUI
//
//  Created by Laurand Osmeni on 02/22/2026.
//  Built by Laurand Osmeni.
//  Tab 3: Searchable leaderboard with dummy global users and signed-in user header.
//

import SwiftUI

struct LeaderboardTabView: View {
    @EnvironmentObject private var appState: AppState
    @State private var searchText: String = ""

    private let users: [LeaderboardUser] = [
        .init(nickname: "Mika", avatarEmoji: "🎯", location: "Tokyo, Japan", score: 9800),
        .init(nickname: "Noah", avatarEmoji: "🚀", location: "Toronto, Canada", score: 9650),
        .init(nickname: "Sara", avatarEmoji: "🌍", location: "London, UK", score: 9500),
        .init(nickname: "Lina", avatarEmoji: "🎮", location: "Tirana, Albania", score: 9420),
        .init(nickname: "Evan", avatarEmoji: "⚡️", location: "Sydney, Australia", score: 9360),
        .init(nickname: "Aria", avatarEmoji: "🧠", location: "Athens, Greece", score: 9270),
        .init(nickname: "Yuri", avatarEmoji: "🛰️", location: "Kyiv, Ukraine", score: 9180),
        .init(nickname: "Mila", avatarEmoji: "🏆", location: "Berlin, Germany", score: 9040)
    ]

    private var filteredUsers: [LeaderboardUser] {
        guard !searchText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return users }
        return users.filter {
            $0.nickname.localizedCaseInsensitiveContains(searchText) ||
            $0.location.localizedCaseInsensitiveContains(searchText)
        }
    }

    var body: some View {
        NavigationStack {
            ContentWidthContainer {
                currentUserCard
                leaderboardListCard
            }
            .navigationTitle("Leaderboard")
            .searchable(text: $searchText, placement: .navigationBarDrawer(displayMode: .always), prompt: "Search nickname or location")
            .keyboardDoneToolbar()
            .onChange(of: searchText) { _, value in
                if !value.isEmpty { appState.speakIfEnabled("Searching leaderboard for \(value)") }
            }
            .onAppear {
                appState.speakIfEnabled("Leaderboard tab. Search players by name or location.")
            }
        }
    }

    private var currentUserCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Signed In User")
                .font(.subheadline.weight(.semibold))
                .foregroundStyle(.secondary)

            HStack(spacing: 12) {
                Text(appState.profile.avatarEmoji.isEmpty ? "🙂" : appState.profile.avatarEmoji)
                    .font(.system(size: 34))
                    .frame(width: 56, height: 56)
                    .background(Circle().fill(appState.theme.backgroundTint))

                VStack(alignment: .leading, spacing: 2) {
                    Text(appState.profile.nickname.isEmpty ? "Player" : appState.profile.nickname)
                        .font(.headline)
                    Text(appState.profile.location.isEmpty ? "No location set" : appState.profile.location)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var leaderboardListCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("Top Players")
                    .font(.title3.bold())
                Spacer()
                Text("\(filteredUsers.count) shown")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            ForEach(Array(filteredUsers.enumerated()), id: \.element.id) { index, user in
                HStack(spacing: 12) {
                    Text("#\(index + 1)")
                        .font(.subheadline.monospacedDigit())
                        .foregroundStyle(.secondary)
                        .frame(width: 36, alignment: .leading)

                    Text(user.avatarEmoji)
                        .font(.title3)

                    VStack(alignment: .leading, spacing: 2) {
                        Text(user.nickname)
                            .font(.headline)
                        Text(user.location)
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Spacer()

                    Text("\(user.score)")
                        .font(.headline.monospacedDigit())
                        .foregroundStyle(appState.theme.accentColor)
                }
                .padding(10)
                .background(appState.theme.backgroundTint, in: RoundedRectangle(cornerRadius: 12))
            }

            if filteredUsers.isEmpty {
                ContentUnavailableView("No players found", systemImage: "magnifyingglass", description: Text("Try another search."))
                    .frame(maxWidth: .infinity)
                    .padding(.top, 8)
            }
        }
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}
