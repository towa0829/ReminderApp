//
//  ReminderApp.swift
//  Reminder
//
//  Created by Takashima Towa on 2026/05/27.
//

import SwiftUI
import SwiftData

@main
struct ReminderApp: App {
    @AppStorage("isDarkMode") private var isDarkMode = false

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ReminderListView()
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .modelContainer(for: [ReminderItem.self, ReminderCategory.self])
    }
}
