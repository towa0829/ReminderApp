//
//  ReminderCategory.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/06/01.
//

import Foundation
import SwiftData

@Model
final class ReminderCategory {
    
    var title: String
    var color: String
    var order: Int
    var createdAt: Date
    
    @Relationship(deleteRule: .cascade)
    var items: [ReminderItem]
    
    init(
        title: String,
        color: String,
        order: Int,
        items: [ReminderItem] = []
    ) {
        self.title = title
        self.color = color
        self.createdAt = Date()
        self.order = order
        self.items = items
    }
}
