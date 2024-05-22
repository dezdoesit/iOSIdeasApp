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
    var inWorks: Bool = false

    init(name: String, detailedDescription: String, inWorks: Bool = false, creationDate: Date = .now) {
        self.name = name
        self.detailedDescription = detailedDescription
        self.inWorks = inWorks
        self.creationDate = creationDate
    }

    @Relationship(deleteRule: .cascade) var features: [AppFeature] = []
}
