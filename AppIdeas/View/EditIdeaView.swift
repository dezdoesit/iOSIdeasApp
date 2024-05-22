//
//  EditIdeaView.swift
//  AppIdeas
//
//  Created by dmoney on 5/21/24.
//

import SwiftUI
import SwiftData

struct EditIdeaView: View {
    @Environment(\.modelContext) private var modelContext
    @Bindable var idea: AppIdea


    @State private var newFeatureDescription = ""

    var body: some View {
        Form {
            TextField("Name", text: $idea.name)

            TextField("Description", text: $idea.detailedDescription, axis: .vertical)

            Section("Features") {
                TextField("New Features", text: $newFeatureDescription)
                    .onSubmit {
                        let feature = AppFeature(detailedDescrition: newFeatureDescription)
                        idea.features.append(feature)
                        newFeatureDescription.removeAll()
                    }

                ForEach(idea.features) { feature in
                    Text(feature.detailedDescrition)
                        .contextMenu {
                            Button(role: .destructive) {
                                idea.features.removeAll(where: { $0 == feature })
                                
                            } label: {
                                Label("Delete Feature", systemImage: "trash")
                            }
                        }
                }
            }
        }
        .navigationTitle(idea.name)
    }
}

//#Preview {
//    EditIdeaView()
//}
