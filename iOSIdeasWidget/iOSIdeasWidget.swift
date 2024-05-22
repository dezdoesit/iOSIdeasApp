//
//  iOSIdeasWidget.swift
//  iOSIdeasWidget
//
//  Created by dmoney on 5/22/24.
//

import WidgetKit
import SwiftUI
import SwiftData

struct Provider: TimelineProvider {
    @MainActor func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), appIdeas: getAppIdeas())
    }

    @MainActor func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), appIdeas: getAppIdeas())
        completion(entry)
    }

    @MainActor func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let timeline = Timeline(entries: [SimpleEntry(date: .now, appIdeas: getAppIdeas())], policy: .after(.now.advanced(by: 60 * 5)))
        completion(timeline)
    }

    @MainActor
    private func getAppIdeas() -> [AppIdea] {
        guard let modelContainer = try?  ModelContainer(for: AppIdea.self) else {
            return []
        }
        let descriptor = FetchDescriptor<AppIdea>()
        let appIdeas = try? modelContainer.mainContext.fetch(descriptor)

        return appIdeas ?? []
    }
}



struct SimpleEntry: TimelineEntry {
    let date: Date
    let appIdeas: [AppIdea]
}

struct iOSIdeasWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {
        VStack {
            ForEach(entry.appIdeas) { idea in
                Button(intent: ToggleWipIntent(appIdeaNmae: idea.name)) {

                }
                HStack {
                    Image(systemName: idea.inWorks ? "pencil.slash" : "pencil")
                        .foregroundStyle(.green)
                    Spacer()
                    Text(idea.name)
                }

            }
        }
    }
}

struct iOSIdeasWidget: Widget {
    let kind: String = "iOSIdeasWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                iOSIdeasWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                iOSIdeasWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemSmall) {
    iOSIdeasWidget()
} timeline: {
    SimpleEntry(date: .now, appIdeas: [])
    SimpleEntry(date: .now, appIdeas: [])
}
