//
//  ReminderListView.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/05/28.
//

import SwiftUI
import SwiftData

struct ReminderListView: View {
    @Environment(\.modelContext)
    private var modelContext
    
    @Query(sort: \ReminderCategory.order)
    private var categories: [ReminderCategory]
    @Query
    private var reminders: [ReminderItem]

    
    @State private var showAddSheet = false
    @AppStorage("isDarkMode") private var isDarkMode = false

    
    var body: some View {
        List {
            ForEach(categories) { category in
                CategorySectionView(category: category)
            }
            .padding(0)
        }
        .listStyle(.plain)
        .listSectionSpacing(16)
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Image(systemName: "chevron.left")
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                Image(systemName: "square.and.arrow.up")
            }
            ToolbarItem(placement: .topBarTrailing) {
                Menu {
                    Button{
                        isDarkMode.toggle()
                    }label: {
                        if isDarkMode {
                            Label("ライトモード", systemImage: "sun.max.fill")
                        } else {
                            Label("ダークモード", systemImage: "moon.fill")
                        }
                    }
                } label: {
                    Image(systemName: "gearshape")
                }
            }
        }
        .overlay(alignment: .bottomTrailing) {
            AddTaskButton(showAddSheet: $showAddSheet)
                .padding()
        }
        .sheet(isPresented: $showAddSheet) {
            AddView()
        }
        .onAppear {
            for reminder in reminders {
                if reminder.title == nil {
                    reminder.title = "(Untitled)"
                }
                if reminder.isCompleted == nil {
                    reminder.isCompleted = false
                }
            }

            if categories.isEmpty {
                let category = ReminderCategory(
                    title: "My Tasks",
                    color: "blue",
                    order: 0
                )
                modelContext.insert(category)

                                        Toggle(isOn: $isDarkMode) {
                                            Label("ダークモード", systemImage: "moon.fill")
                                        }
                                        Divider()
            }

        }
        
    }
}

#Preview {
    NavigationStack {
        ReminderListView()
    }
}
