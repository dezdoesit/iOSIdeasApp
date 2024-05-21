//
//  AppIdeasApp.swift
//  AppIdeas
//
//  Created by dmoney on 5/21/24.
//

import SwiftUI
import SwiftData

@main
struct AppIdeasApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [AppIdea.self, AppFeature.self])
        }
    }
}
