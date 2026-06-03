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
                    ForEach(category.items) { item in
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
                    Text(category.title)
                        .foregroundStyle(
                            CategoryColor(rawValue: category.color
                                         )?.swiftUIColor ?? .blue
                        )
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
                Image(systemName: "ellipsis")
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
            if categories.isEmpty {
                let category = ReminderCategory(
                    title: "My Tasks",
                    color: "blue"
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
