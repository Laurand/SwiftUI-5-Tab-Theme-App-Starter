# 5 Tab SwiftUI Theme Starter (by Laurand Osmeni)

A clean SwiftUI starter project structure you can share on GitHub.

## What is included

- 5 tabs: Profile, Game, Leaderboard, History, Settings
- Theme switching (Red, Blue, Green, Pink, Orange, Purple)
- Accessibility read aloud toggle (AVSpeechSynthesizer)
- Profile saving (nickname, emoji avatar, location, male/female toggle)
- Searchable leaderboard with dummy users
- History screen with clear confirmation (Yes / No)
- Settings pages for App Info, Terms of Use, Privacy Policy
- Build version display from `Bundle`
- iPad friendly content width layout and keyboard Done button helper

## How to use in Xcode

1. Create a new **iOS App** project in Xcode (SwiftUI).
2. Name it `ThemeFiveTabsSwiftUI` (or any name you want).
3. Replace the generated Swift files with the files inside the `ThemeFiveTabsSwiftUI` folder in this zip.
4. Make sure your deployment target supports SwiftUI features used here (recommended iOS 17+).
5. Run on iPhone or iPad.

## Notes

- The speech accessibility feature reads key screen messages when enabled.
- Profile, theme, and history are saved locally using `UserDefaults`.
- Terms and Privacy pages use placeholder text. Replace with your real legal content before release.

Built and structured by Laurand Osmeni.
