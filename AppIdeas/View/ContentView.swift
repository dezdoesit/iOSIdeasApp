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


    var wipIdeas: [AppIdea] {
        ideas.filter { $0.inWorks }
    }

    var nonwipIdeas: [AppIdea] {
        ideas.filter { $0.inWorks == false }
    }


    var body: some View {
        NavigationStack{
            Group { if ideas.isEmpty  {
                ContentUnavailableView("No App Ideas",
                                       systemImage: "rectangle.on.rectangle.slash",
                                       description: Text("Tap Add to create a new App Idea.")


                )

            } else {
                List {
                    Section("Work in Progress") {
                        ForEach(wipIdeas) {
                            IdeaListView(idea: $0)
                        }
                    }
                    Section("All") {
                        ForEach(nonwipIdeas) {
                            IdeaListView(idea: $0)
                        }
                    }
                }
            }
            }
            .navigationTitle("App Ideas")
            .navigationDestination(for: AppIdea.self) { EditIdeaView(idea: $0) }
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
                            resetIdeas()
                        }
                    }
                }
                .presentationDetents([.medium])
            }
        }
    }
    private func resetIdeas() {
        newIdeaName = ""
        newIdeaDescription = ""
    }
}




#Preview {
    ContentView()
        .modelContainer(for: [AppIdea.self, AppFeature.self])
}
