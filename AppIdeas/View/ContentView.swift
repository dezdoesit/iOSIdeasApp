//
//  ContentView.swift
//  AppIdeas
//
//  Created by dmoney on 5/21/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query var ideas: [AppIdea]

    @State private var showAddIdea = false
    @State private var newIdeaName = ""
    @State private var newIdeaDescription = ""



    var body: some View {
        NavigationStack{
            List(ideas) { idea in
                NavigationLink(value: idea) {
                    VStack(alignment: .leading){
                        Text(idea.name)

                        Text(idea.detailedDescription)
                            .textScale(.secondary)
                            .foregroundStyle(.secondary)
                    }
                }
            }
            .navigationTitle("App Ideas")
            .toolbar {
                Button("Add") {
                    showAddIdea.toggle()
                }
            }
            .sheet(isPresented: $showAddIdea) {
                NavigationStack {
                    Form{
                        TextField("Name", text: $newIdeaName)
                        TextField("Description", text: $newIdeaDescription)

                    }
                    .navigationTitle("New App Idea")
                    .toolbar {
                        Button("Cancel") {
                            showAddIdea.toggle()
                        }
                        Button("Save") {
let idea = AppIdea(name: newIdeaName, detailedDescription: newIdeaDescription)
                            modelContext.insert(idea)
                            showAddIdea.toggle()
                        }
                    }
                }
                .presentationDetents([.medium])
            }
        }

    }
}

#Preview {
    ContentView()
        .modelContainer(for: [AppIdea.self, AppFeature.self])
}
