//
//  TabBarView.swift
//  SubsReminder
//
//  Created by Владислав Харин on 13.01.2022.
//

import SwiftUI

struct TabBarView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    var body: some View {
        TabView {
            // Subscribes list tab
            NavigationView {
                ListView()
            }
                .environmentObject(listViewModel)
                .tabItem {
                    Image(systemName: "cloud")
                    Text("My subscriptions")
                }
            
            // Home tab
            NavigationView {
                AddView()
            }
                .environmentObject(listViewModel)
                .tabItem {
                    Image(systemName: "plus")
                    Text("Add")
                }
            
            // Settings tab
            SettingsView()
                .tabItem {
                    Image(systemName: "gearshape")
                    Text("Settings")
                }
        }
    }
}

#if DEBUG
struct TabBarView_Previews: PreviewProvider {
    static var previews: some View {
        TabBarView()
    }
}
#endif
