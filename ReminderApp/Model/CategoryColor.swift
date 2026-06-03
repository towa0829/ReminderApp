//
//  CategoryColor.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/06/02.
//

import Foundation
import SwiftUI

enum CategoryColor: String, CaseIterable {
    
    case blue
    case red
    case green
    case orange
    case purple
    
    var swiftUIColor: Color {
        switch self {
        case .blue:
            return  .blue
        case .red:
            return .red
        case .green:
            return .green
        case .orange:
            return .orange
        case .purple:
            return .purple
        }
    }
}
