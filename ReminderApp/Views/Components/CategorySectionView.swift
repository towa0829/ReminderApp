//
//  CategorySectionView.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/06/03.
//

import SwiftUI
import SwiftData

struct CategorySectionView: View {
    @Environment(\.modelContext)
    private var modelContext

    let category: ReminderCategory

    private var visibleItems: [ReminderItem] {
        category.items.filter { !($0.isCompleted ?? false) }
    }

    var body: some View {
        Section {
            if visibleItems.isEmpty {
                Text("タスクはありません")
                    .foregroundStyle(Color(.secondaryLabel))
            }

            ForEach(visibleItems) { item in
                RemindRowView(reminder: item)
            }
            .onDelete { indexSet in
                for index in indexSet {
                    modelContext.delete(visibleItems[index])
                }
            }
        } header: {
            CategoryHeaderView(category: category)
        }
        .listSectionSeparator(.hidden)
    }
}

#Preview {
    CategorySectionView(
        category: ReminderCategory(
            title: "My Tasks",
            color: "blue",
            order: 0
        )
    )
}
