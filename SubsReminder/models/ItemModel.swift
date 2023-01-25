//
//  ItemModel.swift
//  SubsReminder
//
//  Created by Владислав Харин on 11.01.2022.
//

import Foundation

struct ItemModel: Identifiable, Codable {
    let id: String
    var name: String
    var price: String
    var notes: String
    var currency: Int
    var cycleId: Cycle
    var date: Date
    var notifyMe: Int
    var isTrial: Bool
    var isFamily: Bool
    var icon: String
    
    init(id: String = UUID().uuidString, name: String, price: String, notes: String, currency: Int, cycleId: Cycle, date: Date, notifyMe: Int, isTrial: Bool, isFamily: Bool) {
        self.id = id
        self.name = name
        self.price = price
        self.currency = currency
        self.cycleId = cycleId
        self.date = date
        self.notifyMe = notifyMe
        self.notes = notes
        self.isTrial = isTrial
        self.isFamily = isFamily
        self.icon = "youtube"
    }
    
    func updateComplete() -> ItemModel {
        return ItemModel(id: id, name: self.name, price: self.price, notes: self.notes, currency: self.currency, cycleId: self.cycleId, date: self.date, notifyMe: self.notifyMe, isTrial: self.isTrial, isFamily: self.isFamily)
    }
}
