//
//  ProfileTabView.swift
//  ThemeFiveTabsSwiftUI
//
//  Created by Laurand Osmeni on 02/22/2026.
//  Built by Laurand Osmeni.
//  Tab 1: User profile setup with nickname, emoji avatar, location, and gender toggle.
//

import SwiftUI

struct ProfileTabView: View {
    @EnvironmentObject private var appState: AppState
    @FocusState private var focusedField: Field?

    enum Field {
        case nickname
        case avatar
        case location
    }

    var body: some View {
        NavigationStack {
            ContentWidthContainer {
                headerCard
                profileFormCard
                saveHintCard
            }
            .navigationTitle("Profile")
            .onAppear {
                appState.speakIfEnabled("Profile tab. Update your nickname, avatar, and location.")
            }
        }
    }

    private var headerCard: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Your Profile")
                .font(.title2.bold())

            Text("Set a nickname, emoji avatar, and location. Everything saves automatically on this device.")
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 16))
    }

    private var profileFormCard: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 12) {
                Text(appState.profile.avatarEmoji.isEmpty ? "🙂" : appState.profile.avatarEmoji)
                    .font(.system(size: 40))
                    .frame(width: 64, height: 64)
                    .background(Circle().fill(appState.theme.backgroundTint))

                VStack(alignment: .leading, spacing: 4) {
                    Text(appState.profile.nickname.isEmpty ? "No nickname yet" : appState.profile.nickname)
                        .font(.headline)
                    Text(appState.profile.location.isEmpty ? "Add your location" : appState.profile.location)
                        .foregroundStyle(.secondary)
                }
                Spacer()
            }

            Group {
                TextField("Nickname", text: $appState.profile.nickname)
                    .textInputAutocapitalization(.words)
                    .submitLabel(.done)
                    .focused($focusedField, equals: .nickname)
                    .onSubmit {
                        focusedField = nil
                        let value = appState.profile.nickname.trimmingCharacters(in: .whitespacesAndNewlines)
                        if !value.isEmpty { appState.addHistory("Updated nickname to \(value)") }
                    }
                    .textFieldStyle(.roundedBorder)

                TextField("Emoji Avatar (ex: 😎)", text: $appState.profile.avatarEmoji)
                    .submitLabel(.done)
                    .focused($focusedField, equals: .avatar)
                    .onSubmit { focusedField = nil }
                    .textFieldStyle(.roundedBorder)

                TextField("Location", text: $appState.profile.location)
                    .textInputAutocapitalization(.words)
                    .submitLabel(.done)
                    .focused($focusedField, equals: .location)
                    .onSubmit {
                        focusedField = nil
                        let value = appState.profile.location.trimmingCharacters(in: .whitespacesAndNewlines)
                        if !value.isEmpty { appState.addHistory("Updated location to \(value)") }
                    }
                    .textFieldStyle(.roundedBorder)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Gender")
                    .font(.subheadline.weight(.semibold))

                Toggle(isOn: $appState.profile.isMale) {
                    Text(appState.profile.isMale ? "Male" : "Female")
                }
                .toggleStyle(.switch)
                .onChange(of: appState.profile.isMale) { _, isMale in
                    appState.addHistory("Changed gender toggle to \(isMale ? "Male" : "Female")")
                }
            }
        }
        .padding()
        .background(.regularMaterial, in: RoundedRectangle(cornerRadius: 16))
        .keyboardDoneToolbar()
    }

    private var saveHintCard: some View {
        HStack(spacing: 10) {
            Image(systemName: "checkmark.circle.fill")
                .foregroundStyle(appState.theme.accentColor)
            Text("Profile is saved automatically.")
                .font(.subheadline)
            Spacer()
        }
        .padding()
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 14))
    }
}
