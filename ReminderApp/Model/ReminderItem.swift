//
//  ReminderItem.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/06/01.
//

import Foundation
import SwiftData

@Model
final class ReminderItem {
    var title: String?
    var isCompleted: Bool?
    var dueDate: Date?
    
    init(
        title: String,
        isCompleted: Bool = false,
        dueDate: Date? = nil
    ) {
        self.title = title
        self.isCompleted = isCompleted
        self.dueDate = dueDate
    }
}
