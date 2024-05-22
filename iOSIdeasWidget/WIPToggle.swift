//
//  WIPToggle.swift
//  iOSIdeasWidgetExtension
//
//  Created by dmoney on 5/22/24.
//

import AppIntents
import SwiftData

struct ToggleWipIntent: AppIntent {

    static var title: LocalizedStringResource = "Toggle WIP"
    static var description: IntentDescription? = "Toggles whether an app is being worked on or not"

    @Parameter(title: "App Idea Name")
    var appIdeaName: String

    init() {
        appIdeaName = ""
    }

    init(appIdeaNmae: String) {
        self.appIdeaName = appIdeaNmae
    }

    func perform() async throws -> some IntentResult {
        guard let modelContainer = try?  ModelContainer(for: AppIdea.self) else {
            return .result()
        }
        let descriptor = FetchDescriptor<AppIdea>()
        let appIdeas = try? await modelContainer.mainContext.fetch(descriptor)

        if let idea = appIdeas?.first {
            let inWorks = idea.inWorks
            idea.inWorks = !inWorks
        }

        return .result()
    }
}


