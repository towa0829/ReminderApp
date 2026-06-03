//
//  CategoryHeaderView.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/06/03.
//

import SwiftUI
import SwiftData

struct CategoryHeaderView: View {
    @Environment(\.modelContext)
    private var modelContext

    let category: ReminderCategory

    @State private var isEditSheetPresented = false

    var body: some View {
        HStack {
            Text(category.title)
                .foregroundStyle(
                    CategoryColor(rawValue: category.color)?.swiftUIColor ?? .blue
                )
            Spacer()
            Menu {
                Button {
                    isEditSheetPresented = true
                } label: {
                    Label("カテゴリの編集", systemImage: "pencil")
                }

                Button(role: .destructive) {
                    modelContext.delete(category)
                } label: {
                    Label("カテゴリの削除", systemImage: "trash")
                }
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.white)
            }
        }
        .sheet(isPresented: $isEditSheetPresented) {
            CategoryEditSheetView(
                category: category,
                isPresented: $isEditSheetPresented
            )
        }
    }
}

#Preview {
    CategoryHeaderView(
        category: ReminderCategory(
            title: "My Tasks",
            color: "blue",
            order: 0
        )
    )
}
