//
//  SubscribeViewModel.swift
//  SubsReminder
//
//  Created by Владислав Харин on 13.01.2022.
//

import Foundation
import SwiftUI

/* CRUD */
class SubscribeViewModel: ObservableObject {
    @Published var items: [SubscribeModel] = []
    
    init() {
        getItems()
    }
    
    func getItems() {
        addItem(name: "Spotify", icon: "spotify_white", color: Color.green)
        addItem(name: "YouTube Premium", icon: "youtube", color: Color.white)
        addItem(name: "Tinkoff", icon: "tinkoff", color: Color.yellow)
        addItem(name: "Amazon AWS", icon: "amazon_aws", color: Color.white)
        addItem(name: "Apple Music", icon: "apple_music", color: Color.pink)
        addItem(name: "MTS", icon: "mts", color: Color.red)
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(name: String, icon: String, color: Color) {
        let newItem = SubscribeModel(name: name, icon: icon, color: color)
        items.append(newItem)
    }
}
