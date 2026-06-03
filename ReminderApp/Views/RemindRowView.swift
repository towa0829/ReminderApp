//
//  RemindRowView.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/05/28.
//

import SwiftUI
import SwiftData

struct RemindRowView: View {
    
    let reminder: ReminderItem
    @State private var pendingComplete: DispatchWorkItem?
    @State private var localCompleted: Bool
    @State private var localDueDate: Date?

    init(reminder: ReminderItem) {
        self.reminder = reminder
        _localCompleted = State(initialValue: reminder.isCompleted ?? false)
        _localDueDate = State(initialValue: reminder.dueDate)
    }

    private var dueDateText: String? {
        guard let dueDate = localDueDate else { return nil }

        if Calendar.current.isDateInToday(dueDate) {
            return "本日締め切り"
        }

        if dueDate < Date().addingTimeInterval(60 * 60 * 24) {
            return "本日締め切り"
        }

        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        return formatter.string(from: dueDate)
    }

    private var isDueSoon: Bool {
        guard let dueDate = localDueDate else { return false }
        return dueDate < Date().addingTimeInterval(60 * 60 * 24)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(alignment: .top, spacing: 10) {
                Image(systemName:
                        localCompleted
                      ? "checkmark.circle.fill"
                      : "circle")
                    .padding(.top, 2)
                VStack(alignment: .leading, spacing: 4) {
                    Text(reminder.title ?? "")
                    if let dueDateText {
                        Text(dueDateText)
                            .font(.caption)
                            .foregroundStyle(isDueSoon ? .red : .secondary)
                    }
                }
            }
            Divider()
                .padding(.leading, 30)
                .padding(.top, 8)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .listRowSeparator(.hidden)
        .transition(.opacity)
        .onTapGesture {
            let nextValue = !localCompleted
            localCompleted = nextValue

            if nextValue {
                pendingComplete?.cancel()
                let workItem = DispatchWorkItem {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        reminder.isCompleted = true
                    }
                }
                pendingComplete = workItem
                DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: workItem)
            } else {
                pendingComplete?.cancel()
                pendingComplete = nil
                withAnimation(.easeInOut(duration: 0.2)) {
                    reminder.isCompleted = false
                }
            }
        }
    }
}

#Preview {
    RemindRowView(reminder: ReminderItem(
        title: "実験レポート",
        isCompleted: false
    ))
}
