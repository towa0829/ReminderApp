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
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ReminderListView()
            }
        }
        .modelContainer(for: [ReminderItem.self, ReminderCategory.self])
    }
}
