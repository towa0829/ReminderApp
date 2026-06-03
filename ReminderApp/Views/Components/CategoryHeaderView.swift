//
//  CategoryHeaderView.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/06/03.
//

import SwiftUI

struct CategoryHeaderView: View {
    let title: String
    let colorName: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundStyle(
                    CategoryColor(rawValue: colorName)?.swiftUIColor ?? .blue
                )
            Spacer()
            Button {
                // TODO: category actions
            } label: {
                Image(systemName: "ellipsis")
                    .foregroundStyle(.white)
            }
        }
    }
}

#Preview {
    CategoryHeaderView(title: "My Tasks", colorName: "blue")
}
