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
        .swipeActions(edge: .trailing, allowsFullSwipe: false) {
            Button(role: .destructive) {
                modelContext.delete(idea)
            } label: {
                Label("Delete", systemImage: "trash")
            }
        }
        .swipeActions(edge: .leading, allowsFullSwipe: true) {
            Button{
                idea.inWorks.toggle()
            } label: {
                Label("In the works!", systemImage: idea.inWorks ? "pencil.slash" : "pencil")
            }
            .tint(.green)
        }
        .sensoryFeedback(.decrease, trigger: idea.isDeleted)
        .sensoryFeedback(.increase, trigger: idea.inWorks )
    }
}

