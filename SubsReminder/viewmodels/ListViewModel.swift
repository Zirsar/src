//
//  ListViewModel.swift
//  SubsReminder
//
//  Created by Владислав Харин on 11.01.2022.
//

import Foundation

/* CRUD */
class ListViewModel: ObservableObject {
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    
    let itemsKey: String = "items_list"
    
    init() {
        getItems()
    }
    
    func getItems() {
        guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
        else { return }
        
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet) {
        let toDelete = indexSet.map { self.items[$0].id }
        NotificationManager.instance.deleteNotificationsByIds(ids: toDelete)
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int) {
        items.move(fromOffsets: from, toOffset: to)
    }
    
    func addItem(name: String, price: String, notes: String, currency: Int, cycleId: Cycle, date: Date, notifyMe: Int, isTrial: Bool, isFamily: Bool) {
        let newItem = ItemModel(name: name, price: price, notes: notes, currency: currency, cycleId: cycleId, date: date, notifyMe: notifyMe, isTrial: isTrial, isFamily: isFamily)
        items.append(newItem)
    }
    
    func addReadyItem(item: ItemModel) {
        items.append(item)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index] = item.updateComplete()
        }
    }
    
    func saveItems() {
        if let encodedData = try? JSONEncoder().encode(items) {
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
}
