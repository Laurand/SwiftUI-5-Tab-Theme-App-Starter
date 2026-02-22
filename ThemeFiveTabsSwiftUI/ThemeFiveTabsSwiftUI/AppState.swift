//
//  AppState.swift
//  ThemeFiveTabsSwiftUI
//
//  Created by Laurand Osmeni on 02/22/2026.
//  Built by Laurand Osmeni.
//  Central app state manager: theme, profile, speech accessibility, and history.
//

import SwiftUI
import AVFoundation
import Combine

@MainActor
final class AppState: ObservableObject {
    // MARK: - Published state used by all tabs
    @Published var theme: AppTheme = .blue {
        didSet { saveTheme() }
    }

    @Published var profile: UserProfile = .init() {
        didSet { saveProfile() }
    }

    /// Master accessibility switch for optional read-aloud support across screens.
    @Published var speechEnabled: Bool = false {
        didSet { UserDefaults.standard.set(speechEnabled, forKey: Keys.speechEnabled) }
    }

    /// Optional mute state used by the Game tab top-right button.
    @Published var gameMuted: Bool = false

    @Published var history: [HistoryEntry] = [] {
        didSet { saveHistory() }
    }

    private let speaker = AVSpeechSynthesizer()

    private enum Keys {
        static let theme = "app.theme"
        static let profile = "app.profile"
        static let speechEnabled = "app.speechEnabled"
        static let history = "app.history"
    }

    init() {
        loadTheme()
        loadProfile()
        speechEnabled = UserDefaults.standard.bool(forKey: Keys.speechEnabled)
        loadHistory()

        // Provide a few starter history rows so the History tab is not empty on first launch.
        if history.isEmpty {
            history = [
                HistoryEntry(title: "Opened app"),
                HistoryEntry(title: "Viewed Game tab"),
                HistoryEntry(title: "Checked Leaderboard")
            ]
        }
    }

    // MARK: - Read aloud helper
    /// Reads text out loud when accessibility speech is enabled.
    func speakIfEnabled(_ text: String) {
        guard speechEnabled, !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else { return }
        let utterance = AVSpeechUtterance(string: text)
        utterance.rate = AVSpeechUtteranceDefaultSpeechRate
        utterance.voice = AVSpeechSynthesisVoice(language: "en-US")
        speaker.stopSpeaking(at: .immediate)
        speaker.speak(utterance)
    }

    func addHistory(_ title: String) {
        history.insert(HistoryEntry(title: title), at: 0)
    }

    func clearHistory() {
        history.removeAll()
        addHistory("History cleared")
    }

    // MARK: - Persistence
    private func saveTheme() {
        UserDefaults.standard.set(theme.rawValue, forKey: Keys.theme)
    }

    private func loadTheme() {
        if let raw = UserDefaults.standard.string(forKey: Keys.theme), let saved = AppTheme(rawValue: raw) {
            theme = saved
        }
    }

    private func saveProfile() {
        do {
            let data = try JSONEncoder().encode(profile)
            UserDefaults.standard.set(data, forKey: Keys.profile)
        } catch {
            print("Failed to save profile: \(error)")
        }
    }

    private func loadProfile() {
        guard let data = UserDefaults.standard.data(forKey: Keys.profile) else { return }
        do {
            profile = try JSONDecoder().decode(UserProfile.self, from: data)
        } catch {
            print("Failed to load profile: \(error)")
        }
    }

    private func saveHistory() {
        do {
            let data = try JSONEncoder().encode(history)
            UserDefaults.standard.set(data, forKey: Keys.history)
        } catch {
            print("Failed to save history: \(error)")
        }
    }

    private func loadHistory() {
        guard let data = UserDefaults.standard.data(forKey: Keys.history) else { return }
        do {
            history = try JSONDecoder().decode([HistoryEntry].self, from: data)
        } catch {
            print("Failed to load history: \(error)")
        }
    }
}
