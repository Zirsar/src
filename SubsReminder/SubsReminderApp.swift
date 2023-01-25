//
//  SubsReminderApp.swift
//  SubsReminder
//
//  Created by Владислав Харин on 11.01.2022.
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
