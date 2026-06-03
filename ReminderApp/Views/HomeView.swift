//
//  HomeView.swift
//  ReminderApp
//
//  Created by Takashima Towa on 2026/05/28.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            ReminderListView()
        }
    }
}

#Preview {
    HomeView()
}
