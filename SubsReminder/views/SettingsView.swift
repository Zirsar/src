//
//  SettingsView.swift
//  SubsReminder
//
//  Created by Владислав Харин on 13.01.2022.
//

import SwiftUI

struct Settings {
    static let notifications = "settings_notifications"
    static let hapticEffects = "settings_haptic_effects"
    static let currency = "settings_currency"
    static let notificationTime = "settings_notification_time"
}

struct SettingsView: View {
    @EnvironmentObject var listViewModel: ListViewModel
    
    @AppStorage(Settings.notifications) static var notifications: Bool = true
    @AppStorage(Settings.hapticEffects) static var hapticEffects: Bool = true
    @AppStorage(Settings.currency) static var currency: Int = 2
    @AppStorage(Settings.notificationTime) static var notificationTime: Date = Calendar.current.date(bySettingHour: 10, minute: 00, second: 00, of: Date())!
    
    @State var notifications: Bool = SettingsView.notifications
    @State var notificationTime: Date = SettingsView.notificationTime
    @State var hapticEffects: Bool = SettingsView.hapticEffects
    
    var body: some View {
        NavigationView {
            Form {
                Section(
                    header: Text("App settings"),
                    footer: Text("Here you can customize notifications and change app settings.")) {
                        Toggle("Notifications", isOn: $notifications).onChange(of: notifications) { newValue in
                            SettingsView.notifications = newValue
                            notificationsTrigger()
                        }
                    HStack {
                        Text("Time notification")
                        Spacer()
                        DatePicker("", selection: $notificationTime, displayedComponents: .hourAndMinute).onChange(of: notificationTime) { newValue in
                            SettingsView.notificationTime = newValue
                            notificationTimeTrigger()
                        }
                    }
                    HStack {
                        Text("Currency as default")
                        Spacer()
                        PickerField("", data: Constants.currenciesArray, selectionIndex: SettingsView.$currency).fixedSize()
                    }
                        Toggle("Haptic effects", isOn: $hapticEffects).onChange(of: hapticEffects) { newValue in
                                SettingsView.hapticEffects = newValue
                            }
                }
                Section (
                    header: Text("Contact me"), footer: Text("If you have a suggestion or add a new subscription - contact me!")) {
                    Link("GitHub", destination: URL(string: "http://github.com/vladhacksmile")!)
                    Link("Telegram", destination: URL(string: "http://t.me/embarcadero_studio")!)
                    Link("VKontakte", destination: URL(string: "http://vk.com/vladhacksmile")!)
                }
        }
            .navigationTitle("Settings")
        }
    }
    
    func notificationsTrigger() {
        if(notifications) {
            NotificationManager.instance.addFromArray(subscriptions: listViewModel.items)
        } else {
            NotificationManager.instance.removeAllNotifications()
        }
    }
    
    func notificationTimeTrigger() {
        NotificationManager.instance.updateAllNotifications(subscriptions: listViewModel.items)
    }
}

extension Date: RawRepresentable {
    private static let formatter = ISO8601DateFormatter()
    
    public var rawValue: String {
        Date.formatter.string(from: self)
    }
    
    public init?(rawValue: String) {
        self = Date.formatter.date(from: rawValue) ?? Calendar.current.date(bySettingHour: 10, minute: 00, second: 00, of: Date())!
    }
}

#if DEBUG
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
#endif
