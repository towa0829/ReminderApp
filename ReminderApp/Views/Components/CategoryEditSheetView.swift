//
//  CategoryEditSheetView.swift
//  ReminderApp
//
//  Created by GitHub Copilot on 2026/06/03.
//

import SwiftUI

struct CategoryEditSheetView: View {
    let category: ReminderCategory
    @Binding var isPresented: Bool

    @State private var editTitle: String
    @State private var editColor: CategoryColor

    init(category: ReminderCategory, isPresented: Binding<Bool>) {
        self.category = category
        _isPresented = isPresented
        _editTitle = State(initialValue: category.title)
        _editColor = State(initialValue: CategoryColor(rawValue: category.color) ?? .blue)
    }

    var body: some View {
        NavigationStack {
            Form {
                TextField("カテゴリ名", text: $editTitle)

                Picker("色", selection: $editColor) {
                    ForEach(CategoryColor.allCases, id: \.self) { color in
                        Label {
                            Text(color.rawValue.capitalized)
                        } icon: {
                            Circle()
                                .fill(color.swiftUIColor)
                        }
                        .tag(color)
                    }
                }
            }
            .navigationTitle("カテゴリ編集")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("キャンセル") {
                        isPresented = false
                    }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("保存") {
                        let trimmed = editTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                        if trimmed.isEmpty { return }
                        category.title = trimmed
                        category.color = editColor.rawValue
                        isPresented = false
                    }
                }
            }
        }
    }
}

#Preview {
    CategoryEditSheetView(
        category: ReminderCategory(
            title: "My Tasks",
            color: "blue",
            order: 0
        ),
        isPresented: .constant(true)
    )
}
