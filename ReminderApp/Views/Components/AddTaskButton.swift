//
//  AddTaskButton.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/06/03.
//

import SwiftUI

struct AddTaskButton: View {
    @Binding var showAddSheet: Bool

    var body: some View {
        Button {
            showAddSheet = true
        } label: {
            Image(systemName: "plus")
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
                .padding()
                .background(Color.blue)
                .clipShape(Circle())
        }
    }
}

#Preview {
    AddTaskButton(showAddSheet: .constant(false))
}
