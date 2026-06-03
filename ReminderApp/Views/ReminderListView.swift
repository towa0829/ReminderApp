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

    
    var body: some View {
        List {
            ForEach(categories) { category in
                Section{
                    ForEach(category.items.filter { !($0.isCompleted ?? false) }) { item in
                        RemindRowView(reminder: item)
                    }
                    .onDelete { indexSet in
                        for index in indexSet {
                            modelContext.delete(
                                category.items[index]
                            )
                        }
                    }
                    
                } header: {
                    HStack {
                        Text(category.title)
                        .foregroundStyle(
                            CategoryColor(rawValue: category.color
                                         )?.swiftUIColor ?? .blue
                        )
                        Spacer()
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundStyle(.white)
                        }
                    }
                    
                }
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
                Image(systemName: "gearshape")
            }
        }
        .overlay(alignment: .bottomTrailing) {
            Button {
                showAddSheet = true
            } label: {
                Image(systemName: "plus")
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
                    .padding()
                    .background(Color.blue)
                    .clipShape(Circle())
            }
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

            }

        }
        
    }
}

#Preview {
    NavigationStack {
        ReminderListView()
    }
}
