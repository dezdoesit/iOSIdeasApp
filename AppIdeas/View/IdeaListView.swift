//
//  IdeaListView.swift
//  AppIdeas
//
//  Created by dmoney on 5/21/24.
//

import SwiftUI

struct IdeaListView: View {
    @Environment(\.modelContext) var modelContext
    var idea: AppIdea
    var body: some View {
        NavigationLink(value: idea) {
            VStack(alignment: .leading){
                Text(idea.name)

                Text(idea.detailedDescription)
                    .textScale(.secondary)
                    .foregroundStyle(.secondary)
            }
        }
        .swipeActions {
            Button(role: .destructive) {
                modelContext.delete(idea)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
    }
}

