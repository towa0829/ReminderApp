//
//  CategoryHeaderView.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/06/03.
//

import SwiftUI

struct CategoryHeaderView: View {
    let category: ReminderCategory

    @State private var isModalPresented = false

    var body: some View {
        HStack {
            Text(category.title)
                .foregroundStyle(
                    CategoryColor(rawValue: category.color)?.swiftUIColor ?? .blue
                )
            Spacer()
            Button {
                isModalPresented = true
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.white)
            }
        }
        .sheet(isPresented: $isModalPresented) {
            CategoryActionSheetView(
                category: category,
                isPresented: $isModalPresented
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
