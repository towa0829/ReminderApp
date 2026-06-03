//
//  RemindRowView.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/05/28.
//

import SwiftUI

struct RemindRowView: View {
    let reminder: ReminderItem
    
    var body: some View {
        HStack {
            Image(systemName: 
                    reminder.isCompleted
                  ? "checkmark.circle.fill"
                  : "circle")
                .padding(.trailing, 4)
            Text(reminder.title)
        }
    }
}

#Preview {
    RemindRowView(reminder: ReminderItem(
        title: "実験レポート",
        isCompleted: false
    ))
}
