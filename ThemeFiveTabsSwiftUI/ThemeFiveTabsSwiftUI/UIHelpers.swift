//
//  UIHelpers.swift
//  ThemeFiveTabsSwiftUI
//
//  Created by Laurand Osmeni on 02/22/2026.
//  Built by Laurand Osmeni.
//  Shared UI wrappers to keep layout clean on iPhone and iPad.
//

import SwiftUI
import UIKit

struct ContentWidthContainer<Content: View>: View {
    let content: Content

    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }

    var body: some View {
        GeometryReader { proxy in
            ScrollView {
                VStack(spacing: 16) {
                    content
                }
                .padding()
                .frame(maxWidth: min(proxy.size.width - 24, 700))
                .frame(maxWidth: .infinity)
            }
        }
    }
}

extension View {
    /// Adds a keyboard Done button for text fields and search fields.
    func keyboardDoneToolbar() -> some View {
        self.toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Spacer()
                Button("Done") {
                    UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                }
            }
        }
    }
}
