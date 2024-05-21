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
                
            }
        }
    }

}

#Preview {
    ContentView()
        .modelContainer(for: [AppIdea.self, AppFeature.self])
}
