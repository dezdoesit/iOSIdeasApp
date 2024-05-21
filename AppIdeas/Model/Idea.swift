//
//  Idea.swift
//  AppIdeas
//
//  Created by dmoney on 5/21/24.
//

import Foundation
import SwiftData

@Model
class AppIdea {
    @Attribute(.unique) var name: String
    var detailedDescription: String
    var creationDate: Date

    init(name: String, detailedDescription: String, creationDate: Date = .now) {
        self.name = name
        self.detailedDescription = detailedDescription
        self.creationDate = creationDate
    }

    @Relationship(deleteRule: .cascade) var features: [AppFeature] = []
}
