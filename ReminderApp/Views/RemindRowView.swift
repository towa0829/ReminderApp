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

    init(reminder: ReminderItem) {
        self.reminder = reminder
        _localCompleted = State(initialValue: reminder.isCompleted ?? false)
    }
    
    var body: some View {
        HStack {
            Image(systemName: 
                    localCompleted
                  ? "checkmark.circle.fill"
                  : "circle")
                .padding(.trailing, 4)
            Text(reminder.title ?? "")
        }
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
