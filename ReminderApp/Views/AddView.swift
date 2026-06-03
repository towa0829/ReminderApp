//
//  AddView.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/06/01.
//

import SwiftUI
import SwiftData

struct AddView: View {

    @Environment(\.dismiss) private var dismiss

    @Environment(\.modelContext) private var modelContext

    @Query
    private var categories: [ReminderCategory]

    @State private var mode = 0

    @State private var title = ""
    @State private var selectedCategory: ReminderCategory?
    @State private var selectedColor: CategoryColor = .blue

    var body: some View {

        NavigationStack {

            Form {

                Picker("種類", selection: $mode) {
                    Text("タスク").tag(0)
                    Text("カテゴリ").tag(1)
                }
                .pickerStyle(.segmented)

                if mode == 0 {

                    
                    if categories.isEmpty {
                        Text("カテゴリを作成してください")
                    } else {
                        
                        TextField(
                            "タイトル",
                            text: $title
                        )
                        Picker(
                            "カテゴリ",
                            selection: $selectedCategory
                        ) {

                            ForEach(categories) { category in
                                Text(category.title)
                                    .tag(category as ReminderCategory?)
                            }
                        }
                    }  

                } else {

                    TextField(
                        "カテゴリ名",
                        text: $title
                    )
                    
                    Picker("色", selection: $selectedColor) {

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
            }
            .navigationTitle("追加")
            .toolbar {

                ToolbarItem(
                    placement: .confirmationAction
                ) {

                    Button("保存") {
                        if title.isEmpty { return }
                        save()

                        dismiss()
                    }
                }
            }
            .onAppear {
                if selectedCategory == nil {
                    selectedCategory = categories.first
                }
            }
        }
    }

    private func save() {

        if mode == 0 {

            guard let category = selectedCategory
            else { return }
            if title.isEmpty { return }
            category.items.append(
                ReminderItem(title: title)
            )

        } else {

            if title.isEmpty { return }
            let category =
                ReminderCategory(
                    title: title,
                    color: selectedColor.rawValue,
                    order: categories.count
                )

            modelContext.insert(category)
        }
    }
}
