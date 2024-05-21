//
//  Feature.swift
//  AppIdeas
//
//  Created by dmoney on 5/21/24.
//

import Foundation
import SwiftData

@Model
class AppFeature {
    @Attribute(.unique) var detailedDescrition: String
    var creationDate: Date

    init(detailedDescrition: String, creationDate: Date = .now) {
        self.detailedDescrition = detailedDescrition
        self.creationDate = creationDate
    }
}
