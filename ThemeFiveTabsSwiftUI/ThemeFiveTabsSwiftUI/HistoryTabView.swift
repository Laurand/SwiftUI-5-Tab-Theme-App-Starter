//
//  HistoryTabView.swift
//  ThemeFiveTabsSwiftUI
//
//  Created by Laurand Osmeni on 02/22/2026.
//  Built by Laurand Osmeni.
//  Tab 4: Activity history with greeting and clear history confirmation.
//

import SwiftUI

struct HistoryTabView: View {
    @EnvironmentObject private var appState: AppState
    @State private var showClearConfirm = false

    var body: some View {
        NavigationStack {
            ContentWidthContainer {
                greetingCard
                historyListCard
            }
            .navigationTitle("History")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(role: .destructive) {
                        showClearConfirm = true
                    } label: {
                        Label("Clear", systemImage: "trash")
                    }
                    .disabled(appState.history.isEmpty)
                }
            }
            .confirmationDialog("Clear history?", isPresented: $showClearConfirm, titleVisibility: .visible) {
                Button("Yes, Clear", role: .destructive) {
                    appState.clearHistory()
                    appState.speakIfEnabled("History cleared")
                }
                Button("No", role: .cancel) { }
            } message: {
                Text("This removes all saved history items on this device.")
            }
            .onAppear {
                let nickname = appState.profile.nickname.isEmpty ? "Player" : appState.profile.nickname
                appState.speakIfEnabled("History tab. Hello \(nickname).")
            }
        }
    }

    private var greetingCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Hello \(appState.profile.nickname.isEmpty ? "Player" : appState.profile.nickname)")
                .font(.title2.bold())

            Button {
                showClearConfirm = true
            } label: {
                Text("Clear History")
                    .frame(maxWidth: 240)
                    .frame(height: 42)
            }
            .buttonStyle(.borderedProminent)
            .tint(appState.theme.accentColor)
            .disabled(appState.history.isEmpty)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var historyListCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Recent Activity")
                .font(.title3.bold())

            if appState.history.isEmpty {
                ContentUnavailableView("No History", systemImage: "clock", description: Text("Your activity will appear here."))
                    .frame(maxWidth: .infinity)
                    .padding(.vertical, 8)
            } else {
                ForEach(appState.history) { entry in
                    HStack(alignment: .top, spacing: 12) {
                        Image(systemName: "clock.fill")
                            .foregroundStyle(appState.theme.accentColor)
                            .padding(.top, 2)

                        VStack(alignment: .leading, spacing: 4) {
                            Text(entry.title)
                            Text(entry.timestamp.formatted(date: .abbreviated, time: .shortened))
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                        Spacer()
                    }
                    .padding(10)
                    .background(appState.theme.backgroundTint, in: RoundedRectangle(cornerRadius: 12))
                }
            }
        }
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }
}
