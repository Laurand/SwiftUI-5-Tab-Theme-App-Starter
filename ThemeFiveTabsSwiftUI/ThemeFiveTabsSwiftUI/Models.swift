//
//  Models.swift
//  ThemeFiveTabsSwiftUI
//
//  Created by Laurand Osmeni on 02/22/2026.
//  Built by Laurand Osmeni.
//

import SwiftUI

/// App-wide theme options users can switch between in Settings.
enum AppTheme: String, CaseIterable, Identifiable, Codable {
    case red, blue, green, pink, orange, purple

    var id: String { rawValue }

    var displayName: String {
        switch self {
        case .red: return "Red"
        case .blue: return "Blue"
        case .green: return "Green"
        case .pink: return "Pink"
        case .orange: return "Orange"
        case .purple: return "Purple"
        }
    }

    /// Primary accent used across the app.
    var accentColor: Color {
        switch self {
        case .red: return .red
        case .blue: return .blue
        case .green: return .green
        case .pink: return .pink
        case .orange: return .orange
        case .purple: return .purple
        }
    }

    /// Soft background tint to make each theme feel visually different.
    var backgroundTint: Color {
        switch self {
        case .red: return Color.red.opacity(0.08)
        case .blue: return Color.blue.opacity(0.08)
        case .green: return Color.green.opacity(0.08)
        case .pink: return Color.pink.opacity(0.08)
        case .orange: return Color.orange.opacity(0.08)
        case .purple: return Color.purple.opacity(0.08)
        }
    }

    /// Optional color scheme preference. Kept nil so user device preference remains respected.
    var preferredColorScheme: ColorScheme? { nil }
}

/// Simple profile model persisted locally.
struct UserProfile: Codable {
    var nickname: String = ""
    var avatarEmoji: String = "🙂"
    var location: String = ""
    var isMale: Bool = true
}

/// Dummy leaderboard entry model for tab 3.
struct LeaderboardUser: Identifiable, Hashable {
    let id = UUID()
    let nickname: String
    let avatarEmoji: String
    let location: String
    let score: Int
}

/// Simple history entry used by tab 4.
struct HistoryEntry: Identifiable, Hashable, Codable {
    let id: UUID
    let title: String
    let timestamp: Date

    init(id: UUID = UUID(), title: String, timestamp: Date = Date()) {
        self.id = id
        self.title = title
        self.timestamp = timestamp
    }
}
