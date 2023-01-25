//
//  NotificationManager.swift
//  SubsReminder
//
//  Created by Владислав Харин on 12.01.2022.
//

import Foundation
import UserNotifications
import UIKit
import SwiftUI

class NotificationManager: UIResponder, UIApplicationDelegate {
    static let instance = NotificationManager() // Singletone
    
    func preparePeriodOnDay(notifyDay: Int) -> String {
        return (notifyDay == 0 ? "today" : notifyDay == 1 ? "tommorow" : "for " + String(notifyDay) + " days")
    }
    
    func getNotifyDays(notifyMe: Int) -> Int {
        var notifyDay = 0
        switch(notifyMe) {
            case 1:
                notifyDay = 0
                break
            case 2:
                notifyDay = 1
                break
            case 3:
                notifyDay = 3
                break
            case 4:
                notifyDay = 5
                break
            case 5:
                notifyDay = 7
                break
            case 6:
                notifyDay = 10
                break
            case 7:
                notifyDay = 14
                break
            // Если пришло то, что не ожидалось или 0 - не будем формировать уведомление
            default:
                return -1
        }
        return notifyDay
    }
    
    func getCalendarComponent(cycleId: Cycle) -> Set<Calendar.Component> {
        var calendarComponent: Set<Calendar.Component>
        switch(cycleId) {
            case .day:
                    calendarComponent = []
                break
            case .weak:
                    calendarComponent = [.weekday]
                break
            case .month:
                    calendarComponent = [.day]
                break
            case .year:
                    calendarComponent = [.day, .month]
                break
        }
        return calendarComponent
    }
    
    func updateAllNotifications(subscriptions: [ItemModel]) {
        removeAllNotifications()
        addFromArray(subscriptions: subscriptions)
    }
    
    func updateNotification(subscription: ItemModel) {
        deleteNotificationById(id: subscription.id)
        scheduleNotification(subscribe: subscription)
    }
    
    func addFromArray(subscriptions: [ItemModel]) {
        for sub in subscriptions {
            scheduleNotification(subscribe: sub)
        }
    }
    
    func removeAllNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
    }
    
    func deleteNotificationById(id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
    }
    
    func deleteNotificationsByIds(ids: [String]) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ids)
    }
    
    func requestAuthorization() -> Bool {
        var status: Bool = false
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { (success, error) in
            if let error = error {
                print("Error auth notification \(error)")
            } else {
                status = true
            }
        }
        return status
    }
    
    func scheduleNotification(subscribe: ItemModel) {
        let notifyDay: Int = getNotifyDays(notifyMe: subscribe.notifyMe)
        
        if (!SettingsView.notifications || notifyDay == -1) { return }
        
        requestAuthorization()
        
        // let currentDate = Date()
        // let preparedTime = Calendar.current.date(byAdding: .minute, value: 1, to: currentDate) ?? currentDate
        
        let preparedDate = Calendar.current.date(byAdding: .day, value: -notifyDay, to: subscribe.date) ?? subscribe.date
        
        let calendarComponent: Set<Calendar.Component> = getCalendarComponent(cycleId: subscribe.cycleId)
        
        var preparedDateComponents = Calendar.current.dateComponents(calendarComponent, from: preparedDate)
        preparedDateComponents.hour = Calendar.current.component(.hour, from: SettingsView.notificationTime)
        preparedDateComponents.minute = Calendar.current.component(.minute, from: SettingsView.notificationTime)
        
        let content = UNMutableNotificationContent()
        content.title = subscribe.name + " - pay " + preparePeriodOnDay(notifyDay: notifyDay)
        content.body = "Price of subscription - " + Constants.currencies[subscribe.currency] + " " + subscribe.price + ", it will be extended automatically!"
        content.sound = .default
        content.badge = 1 // TODO
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: preparedDateComponents, repeats: true)
       
        let request = UNNotificationRequest(
            identifier: subscribe.id,
            content: content,
            trigger: trigger)
        
        UNUserNotificationCenter.current().delegate = self
        UNUserNotificationCenter.current().add(request)
    }
}

extension NotificationManager: UNUserNotificationCenterDelegate {
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        print("DEBUG 1")
        print(#function)
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .list, .sound])
        print("DEBUG 2")
        print(#function)
    }
}
