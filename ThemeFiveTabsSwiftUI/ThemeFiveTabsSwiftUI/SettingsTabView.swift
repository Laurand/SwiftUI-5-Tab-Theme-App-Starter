//
//  SettingsTabView.swift
//  ThemeFiveTabsSwiftUI
//
//  Created by Laurand Osmeni on 02/22/2026.
//  Built by Laurand Osmeni.
//  Tab 5: Theme picker, accessibility speech, app info, terms, policy, and app version details.
//

import SwiftUI

struct SettingsTabView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        NavigationStack {
            List {
                themeSection
                accessibilitySection
                legalSection
                appInfoSection
            }
            .navigationTitle("Settings")
            .onAppear {
                appState.speakIfEnabled("Settings tab. You can change themes and accessibility options.")
            }
        }
    }

    private var themeSection: some View {
        Section("Theme Colors") {
            Picker("App Theme", selection: $appState.theme) {
                ForEach(AppTheme.allCases) { theme in
                    HStack {
                        Circle()
                            .fill(theme.accentColor)
                            .frame(width: 14, height: 14)
                        Text(theme.displayName)
                    }
                    .tag(theme)
                }
            }
            .pickerStyle(.menu)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 10) {
                    ForEach(AppTheme.allCases) { theme in
                        Button {
                            appState.theme = theme
                            appState.addHistory("Changed theme to \(theme.displayName)")
                            appState.speakIfEnabled("Theme changed to \(theme.displayName)")
                        } label: {
                            HStack(spacing: 8) {
                                Circle().fill(theme.accentColor).frame(width: 12, height: 12)
                                Text(theme.displayName)
                                    .font(.subheadline.weight(.medium))
                            }
                            .padding(.horizontal, 12)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(theme == appState.theme ? theme.backgroundTint : Color(.secondarySystemBackground))
                            )
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(.vertical, 4)
            }
        }
    }

    private var accessibilitySection: some View {
        Section("Accessibility") {
            Toggle("Read app content out loud", isOn: $appState.speechEnabled)
                .onChange(of: appState.speechEnabled) { _, enabled in
                    appState.addHistory(enabled ? "Enabled speech accessibility" : "Disabled speech accessibility")
                    if enabled { appState.speakIfEnabled("Speech accessibility enabled") }
                }

            Text("When enabled, the app can read key screen messages aloud using system speech.")
                .font(.footnote)
                .foregroundStyle(.secondary)
        }
    }

    private var legalSection: some View {
        Section("Legal") {
            NavigationLink("Terms of Use") {
                StaticTextPageView(
                    title: "Terms of Use",
                    bodyText: "This is a sample Terms of Use page for your GitHub starter project. Replace this text with your real terms before publishing a production app.\n\nUsers are responsible for using the app in a lawful and respectful way. Features and content may change over time."
                )
            }

            NavigationLink("Privacy Policy") {
                StaticTextPageView(
                    title: "Privacy Policy",
                    bodyText: "This is a sample Privacy Policy page for your GitHub starter project. Update this with your actual data handling details before release.\n\nThis starter stores profile, theme, and history locally on the device using UserDefaults."
                )
            }
        }
    }

    private var appInfoSection: some View {
        Section("App Info") {
            NavigationLink("About This App") {
                AppInfoView()
            }

            HStack {
                Text("Build Version")
                Spacer()
                Text(Bundle.appVersionDisplay)
                    .foregroundStyle(.secondary)
            }
        }
    }
}

struct StaticTextPageView: View {
    @EnvironmentObject private var appState: AppState
    let title: String
    let bodyText: String

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(title)
                    .font(.title2.bold())
                Text(bodyText)
                    .foregroundStyle(.primary)
                Spacer(minLength: 0)
            }
            .padding()
            .frame(maxWidth: 700, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .navigationTitle(title)
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            appState.speakIfEnabled(title)
        }
    }
}

struct AppInfoView: View {
    @EnvironmentObject private var appState: AppState

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 14) {
                Text("5 Tab SwiftUI Theme Starter")
                    .font(.title2.bold())

                Text("A structured SwiftUI starter project with five tabs, theme switching, profile persistence, leaderboard search, history management, and accessibility speech support.")

                VStack(alignment: .leading, spacing: 8) {
                    Label("Built with SwiftUI", systemImage: "swift")
                    Label("Created by Laurand Osmeni", systemImage: "person.crop.circle")
                    Label("Version: \(Bundle.appVersionDisplay)", systemImage: "number")
                }
                .foregroundStyle(.secondary)

                Spacer(minLength: 0)
            }
            .padding()
            .frame(maxWidth: 700, alignment: .leading)
            .frame(maxWidth: .infinity, alignment: .center)
        }
        .navigationTitle("App Info")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            appState.speakIfEnabled("App Info page")
        }
    }
}

extension Bundle {
    /// Returns a friendly version string like 1.0 (1).
    static var appVersionDisplay: String {
        let version = main.object(forInfoDictionaryKey: "CFBundleShortVersionString") as? String ?? "1.0"
        let build = main.object(forInfoDictionaryKey: "CFBundleVersion") as? String ?? "1"
        return "\(version) (\(build))"
    }
}
