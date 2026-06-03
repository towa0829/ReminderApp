//
//  CategoryActionSheetView.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/06/03.
//

import SwiftUI
import SwiftData

struct CategoryActionSheetView: View {
    @Environment(\.modelContext)
    private var modelContext

    let category: ReminderCategory

    @Binding var isPresented: Bool

    @State private var editTitle: String
    @State private var editColor: CategoryColor
    @State private var showDeleteConfirm = false

    init(category: ReminderCategory, isPresented: Binding<Bool>) {
        self.category = category
        _isPresented = isPresented
        _editTitle = State(initialValue: category.title)
        _editColor = State(initialValue: CategoryColor(rawValue: category.color) ?? .blue)
    }

    var body: some View {
        NavigationStack {
            Form {
                Section("カテゴリ編集") {
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
                    Button("保存") {
                        let trimmed = editTitle.trimmingCharacters(in: .whitespacesAndNewlines)
                        if trimmed.isEmpty { return }
                        category.title = trimmed
                        category.color = editColor.rawValue
                        isPresented = false
                    }
                }



                Section {
                    Button("カテゴリを削除", role: .destructive) {
                        modelContext.delete(category)
                        isPresented = false
                    }
                }
            }
            .navigationTitle("カテゴリ設定")
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("閉じる") {
                        isPresented = false
                    }
                }
            }

        }
    }
}

#Preview {
    CategoryActionSheetView(
        category: ReminderCategory(
            title: "My Tasks",
            color: "blue",
            order: 0
        ),
        isPresented: .constant(true)
    )
}
