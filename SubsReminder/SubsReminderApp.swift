//
//  SubsReminderApp.swift
//  SubsReminder
//

import SwiftUI

@main
struct SubsReminderApp: App {

    @StateObject var listViewModel: ListViewModel = ListViewModel()
    var body: some Scene {
        WindowGroup {
            TabBarView()
            .environmentObject(listViewModel)
            .navigationViewStyle(StackNavigationViewStyle()) // adaptation for iPads
        }
    }
}
