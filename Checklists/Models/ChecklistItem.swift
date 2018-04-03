//
//  ChecklistItem.swift
//  Checklists
//
//  Created by Larissa Barra Conde on 27/03/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import Foundation
import UserNotifications

class ChecklistItem: NSObject, Codable {
    var text = ""
    var checked = false
    var dueDate = Date()
    var shouldRemind = false
    var itemID: Int
    
    init(text: String, checked: Bool, dueDate: Date, shouldRemind: Bool) {
        self.text = text
        self.checked = checked
        self.itemID = ChecklistDataPersistence.nextChecklistItemID()
        
        super.init()
    }
    
    deinit {
        removeNotification()
    }
    
    func toggleChecked() {
        self.checked = !self.checked
    }
    
    func scheduleNotification() {
        removeNotification()
        
        if shouldRemind && dueDate > Date() {
            let content = UNMutableNotificationContent()
            content.title = "Reminder:"
            content.body = text
            content.sound = UNNotificationSound.default()

            let calendar = Calendar(identifier: .gregorian)
            let components = calendar.dateComponents([.month, .day, .hour, .minute], from: dueDate)

            let trigger = UNCalendarNotificationTrigger( dateMatching: components, repeats: false)

            let request = UNNotificationRequest( identifier: "\(itemID)", content: content, trigger: trigger)

            let center = UNUserNotificationCenter.current()
            center.add(request)
        }
    }
    
    func removeNotification() {
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: ["\(itemID)"])
    }
}
