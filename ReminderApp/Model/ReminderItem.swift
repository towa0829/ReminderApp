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
    
    init(
        title: String,
        isCompleted: Bool = false
    ) {
        self.title = title
        self.isCompleted = isCompleted
    }
}
